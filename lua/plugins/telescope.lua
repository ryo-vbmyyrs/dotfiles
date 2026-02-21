return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- jdtでJavaのファイルをプレビューするためのPreviewer定義
        local function jdt_previewer()
            return require('telescope.previewers').new_buffer_previewer({
                title = 'Preview',
                define_preview = function(self, entry)
                    local filepath = entry.filename or entry.path
                    if filepath and vim.startswith(filepath, 'jdt://') then
                        local jdtls_bufnr = nil
                        for _, client in ipairs(vim.lsp.get_clients({ name = 'jdtls' })) do
                            local bufs = vim.tbl_keys(client.attached_buffers)
                            if #bufs > 0 then
                                jdtls_bufnr = bufs[1]
                                break
                            end
                        end
                        if not jdtls_bufnr then
                            return
                        end

                        vim.lsp.buf_request(
                            jdtls_bufnr,
                            'java/classFileContents',
                            { uri = filepath },
                            function(err, result)
                                if err or not result then
                                    return
                                end
                                vim.schedule(function()
                                    local bufnr = self.state.bufnr
                                    if not vim.api.nvim_buf_is_valid(bufnr) then
                                        return
                                    end
                                    vim.bo[bufnr].modifiable = true
                                    vim.api.nvim_buf_set_lines(
                                        bufnr,
                                        0,
                                        -1,
                                        false,
                                        vim.split(result, '\n')
                                    )
                                    vim.bo[bufnr].filetype = 'java'
                                    vim.bo[bufnr].modifiable = false

                                    -- 該当行にスクロール
                                    if entry.lnum then
                                        vim.api.nvim_win_set_cursor(
                                            self.state.winid,
                                            { entry.lnum, entry.col or 0 }
                                        )
                                        -- 画面中央に寄せる
                                        vim.api.nvim_win_call(self.state.winid, function()
                                            vim.cmd('normal! zz')
                                        end)

                                        -- 該当行をハイライト
                                        vim.api.nvim_buf_add_highlight(
                                            bufnr,
                                            0, -- namespace (0で一時的)
                                            'TelescopePreviewLine', -- ハイライトグループ
                                            entry.lnum - 1, -- 0-indexed
                                            0,
                                            -1 -- 行末まで
                                        )
                                    end
                                end)
                            end
                        )
                    else
                        require('telescope.config').values.buffer_previewer_maker(
                            filepath,
                            self.state.bufnr,
                            {
                                bufname = self.state.bufname,
                            }
                        )
                    end
                end,
            })
        end

        local function lsp_entry_maker(opts)
            local default_maker = require('telescope.make_entry').gen_from_quickfix(opts)
            return function(entry)
                local result = default_maker(entry)
                if result and result.filename and vim.startswith(result.filename, 'jdt://') then
                    local short = result.filename:match('%(([^(]+)$')
                        or result.filename:match('[^/]+$')
                    result.display = function(e)
                        return short .. ':' .. (e.lnum or ''), {}
                    end
                end
                return result
            end
        end

        local pickers = {
            find_files = {
                hidden = true,
            },
        }
        local lsp_pickers = {
            'lsp_implementations',
            'lsp_references',
            'lsp_definitions',
            'lsp_type_definitions',
            'lsp_incoming_calls',
            'lsp_outgoing_calls',
        }

        for _, picker in ipairs(lsp_pickers) do
            pickers[picker] = {
                previewer = jdt_previewer(),
                entry_maker = lsp_entry_maker(),
            }
        end

        require('telescope').setup({
            defaults = {
                mappings = {
                    -- insert mode
                    i = { ['?'] = 'which_key' },
                    -- normal mode
                    n = { ['?'] = 'which_key' },
                },
                winblend = 20,
                path_display = { 'smart', 'truncate' },
            },
            pickers = pickers,
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope find commands' })
        vim.keymap.set(
            'n',
            '<leader>/',
            builtin.current_buffer_fuzzy_find,
            { desc = 'Telescope fuzzy find in current buffer' }
        )
    end,
}
