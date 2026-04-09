return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter').setup({
            ensure_installed = {
                'apex',
                'html',
                'java',
                'javadoc',
                'javascript',
                'jsdoc',
                'lua',
                'markdown',
                'python',
                'soql',
                'terraform',
                'tsx',
                'typescript',
                'xml',
            },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },
            indent = {
                enable = true,
            },
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = vim.tbl_keys(require('nvim-treesitter.parsers')),
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
