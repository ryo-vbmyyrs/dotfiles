return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvimtools/none-ls-extras.nvim' },
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            debug = true,
            sources = {
                null_ls.builtins.formatting.prettier.with({
                    prefer_local = 'node_modules/.bin',
                    extra_args = function(params)
                        local config_path = params.root .. '/.prettierrc.json'
                        if vim.fn.filereadable(config_path) == 1 then
                            return { '--config', config_path }
                        end
                    end,
                }),
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
                require('none-ls.diagnostics.eslint').with({
                    condition = function(utils)
                        return utils.root_has_file({
                            '.eslintrc.js',
                            '.eslintrc.cjs',
                            '.eslintrc.yaml',
                            '.eslintrc.yml',
                            '.eslintrc.json',
                            '.eslintrc.config.js',
                        })
                    end,
                }),
                null_ls.builtins.completion.spell,
            },
            on_attach = function(client, bufnr)
                if client.supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        callback = function()
                            local ft = vim.bo.filetype
                            if ft == 'java' or ft == 'yaml' or ft == 'markdown' then
                                return
                            end

                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                filter = function(c)
                                    return c.name == 'null-ls'
                                end,
                            })
                        end,
                    })
                end
            end,
        })

        local json_format = function()
            vim.bo.filetype = 'json'
            vim.cmd('%!jq .')
        end

        vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = 'Format buffer' })
        vim.keymap.set('n', '<leader>fj', json_format, { desc = 'Format buffer JSON' })
    end,
}
