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
            .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
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
            .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
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
        vim.fn.glob(
            mason_jdtls_path
                .. (vim.fn.has('win32') == 1 and '\\' or '/')
                .. 'plugins'
                .. (vim.fn.has('win32') == 1 and '\\' or '/')
                .. 'org.eclipse.equinox.launcher_*.jar'
        ),
        '-configuration',
        mason_jdtls_path .. (vim.fn.has('win32') == 1 and '\\' or '/') .. get_os_config(),
        '-data',
        workspace_path,
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),

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
                -- settings = {
                --   url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
                --   profile = "GoogleStyle",
                -- },
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
