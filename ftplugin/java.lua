-- JDTLS (Java LSP) configuration
local jdtls = require('jdtls')

-- Determine OS and setup paths
local function get_home_dir()
    if vim.fn.has('win32') == 1 then
        return os.getenv('USERPROFILE')
    else
        return os.getenv('HOME')
    end
end

local function get_workspace_dir()
    local home = get_home_dir()
    local sep = vim.fn.has('win32') == 1 and '\\' or '/'
    if vim.fn.has('win32') == 1 then
        -- Windows: Use AppData/Local for workspace
        return home
            .. sep
            .. 'AppData'
            .. sep
            .. 'Local'
            .. sep
            .. 'eclipse'
            .. sep
            .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~'):gsub('[/\\~]', '_')
    else
        -- Unix-like: Use .local/share
        return home
            .. sep
            .. '.local'
            .. sep
            .. 'share'
            .. sep
            .. 'eclipse'
            .. sep
            .. vim.fn.fnamemodify(vim.fn.getcwd(), ':~'):gsub('[/\\~]', '_')
    end
end

local function get_mason_path()
    -- Mason uses vim.fn.stdpath('data') which is OS-aware
    local sep = vim.fn.has('win32') == 1 and '\\' or '/'
    return vim.fn.stdpath('data') .. sep .. 'mason' .. sep .. 'packages' .. sep .. 'jdtls'
end

local function get_lombok_path(jdtls_path)
    local sep = vim.fn.has('win32') == 1 and '\\' or '/'
    return jdtls_path .. sep .. 'lombok.jar'
end

local workspace_path = get_workspace_dir()
local mason_jdtls_path = get_mason_path()

-- Function to get the OS-specific config directory
local function get_os_config()
    if vim.fn.has('mac') == 1 then
        return 'config_mac'
    elseif vim.fn.has('win32') == 1 then
        return 'config_win'
    else
        return 'config_linux'
    end
end

-- jarを見つけるための関数
local function find_equinox_launcher(jdtls_path)
    local sep = vim.fn.has('win32') == 1 and '\\' or '/'
    local plugins_dir = jdtls_path .. sep .. 'plugins'

    -- ディレクトリが存在するか確認
    if vim.fn.isdirectory(plugins_dir) == 0 then
        error('Plugins directory not found: ' .. plugins_dir)
    end

    local files = vim.fn.readdir(plugins_dir, function(name)
        return vim.startswith(name, 'org.eclipse.equinox.launcher_')
            and vim.endswith(name, '.jar')
            and not name:find('%.cocoa%.') -- macOS用を除外
            and not name:find('%.gtk%.') -- Linux用を除外
            and not name:find('%.win32%.') -- Windows native launcherを除外
    end)

    if #files == 0 then
        error('Could not find equinox launcher jar in: ' .. plugins_dir)
    end

    local jar_path = plugins_dir .. sep .. files[1]
    return jar_path
end

local equinox_jar = find_equinox_launcher(mason_jdtls_path)

local root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
if not root_dir then
    root_dir = vim.fn.getcwd()
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        'java',
        '-javaagent:' .. get_lombok_path(mason_jdtls_path),
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        equinox_jar,
        '-configuration',
        mason_jdtls_path .. (vim.fn.has('win32') == 1 and '\\' or '/') .. get_os_config(),
        '-data',
        workspace_path,
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.uri_from_fname(root_dir .. '\\config\\eclipse-java-format.xml'),
                    profile = 'IntelliJ-Based',
                },
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
            importOrder = {
                'java',
                'javax',
                'com',
                'org',
            },
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    },

    flags = {
        allow_incremental_sync = true,
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {},
    },

    on_attach = function(client, bufnr)
        vim.notify('attached!')
        local augroup = vim.api.nvim_create_augroup('jdtls_format_' .. bufnr, { clear = true })
    end,

    -- Keymaps
    -- on_attach = function(client, bufnr)
    --     -- Regular LSP keymaps
    --     local opts = { noremap = true, silent = true, buffer = bufnr }
    --     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    --     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    --     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    --     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --     vim.keymap.set('n', '<leader>f', function()
    --         vim.lsp.buf.format({ async = true })
    --     end, opts)

    --     -- JDTLS specific keymaps
    --     vim.keymap.set('n', '<leader>co', jdtls.organize_imports, opts)
    --     vim.keymap.set('n', '<leader>cv', jdtls.extract_variable, opts)
    --     vim.keymap.set('n', '<leader>cc', jdtls.extract_constant, opts)
    --     vim.keymap.set(
    --         'v',
    --         '<leader>cm',
    --         [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    --         opts
    --     )
    -- end,
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
