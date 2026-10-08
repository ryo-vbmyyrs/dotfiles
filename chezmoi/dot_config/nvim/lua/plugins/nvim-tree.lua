-- disable netrw
vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)

return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        {
            mode = 'n',
            '<C-t>',
            '<cmd>NvimTreeToggle<CR>',
            desc = 'NvimTreeをトグルする',
        },
        {
            mode = 'n',
            '<C-m>',
            '<cmd>NvimTreeFocus<CR>',
            desc = 'NvimTreeにフォーカス',
        },
    },
    config = function()
        require('nvim-tree').setup({
            git = {
                enable = true,
                ignore = true,
            },
            view = {
                width = '20%',
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                highlight_opened_files = 'name',
                icons = {
                    glyphs = {
                        git = {
                            unstaged = '!',
                            renamed = '→',
                            untracked = '?',
                            deleted = '✗',
                            staged = '✓',
                        },
                    },
                },
            },
            actions = {
                expand_all = {
                    max_folder_discovery = 200,
                    exclude = { '.git', 'target', 'build' },
                },
            },
            on_attach = function(bufnr)
                require('plugins/actions/nvim-tree-actions').on_attach(bufnr)
            end,
        })

        -- open File Tree when open
        vim.api.nvim_create_autocmd({ 'VimEnter' }, {
            callback = function()
                require('nvim-tree.api').tree.open()
            end,
        })
    end,
}
