return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        '--column-width',
                        '100',
                        '--line-endings',
                        'Unix',
                        '--indent-type',
                        'Spaces',
                        '--indent-width',
                        '4',
                        '--quote-style',
                        'AutoPreferSingle',
                        '--call-parentheses',
                        'Always',
                    },
                }),
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.completion.spell,
            },
            on_attach = function(client, bufnr)
                if client.supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end,
}
