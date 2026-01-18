return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ravitemer/mcphub.nvim',
        'ravitemer/codecompanion-history.nvim',
        'lalitmee/codecompanion-spinners.nvim',
    },
    config = function()
        require('codecompanion').setup({
            strategies = {
                chat = {
                    adapter = {
                        name = 'copilot',
                        model = 'claude-sonnet-4.5',
                    },
                },
                inline = {
                    adapter = {
                        name = 'copilot',
                        model = 'claude-sonnet-4.5',
                    },
                },
            },
            display = {
                chat = {
                    window = {
                        layout = 'vertical',
                        width = 0.35,
                        height = 1,
                    },
                    auto_scroll = true,
                    show_token_count = true,
                },
            },
            extensions = {
                mcphub = {
                    callback = 'mcphub.extensions.codecompanion',
                    opts = {
                        make_tools = true,
                        show_server_tools_in_chat = true,
                        add_mcp_prefix_to_tool_names = true,
                        show_result_in_chat = true,
                        make_vars = true,
                        make_slash_commands = true,
                    },
                },
                history = {
                    enable = true,
                    opts = {
                        keymap = 'gh',
                        auto_generate_title = true,
                        continue_last_chat = false,
                        delete_on_clearing_chat = false,
                        picker = 'telescope',
                        enable_logging = false,
                        dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
                        auto_save = true,
                        save_chat_keymap = 'sc',
                    },
                },
                spinner = {
                    opts = {
                        style = 'native',
                        native = {
                            done_timer = 500,
                            window = {
                                relative = 'editor',
                                width = 30,
                                height = 1,
                                row = vim.o.lines - 5,
                                col = vim.o.columns - 35,
                                style = 'minimal',
                                border = 'rounded',
                                title = 'CodeCompanion',
                                title_pos = 'center',
                                focusable = false,
                                noautocmd = true,
                            },
                            win_options = {
                                winblend = 10,
                                winhighlight = 'Normal:Normal,FloatBorder:Normal',
                            },
                        },
                    },
                },
            },
            opts = {
                system_prompt = function(opts)
                    return 'あなたは日本語で回答するAIアシスタントです。'
                end,
                language = 'Japanese',
                log_level = 'ERROR',
                send_code = true,
            },
        })

        vim.keymap.set(
            { 'n', 'v' },
            '<leader>aa',
            '<cmd>CodeCompanionChat Toggle<CR>',
            { noremap = true, silent = true }
        )
        vim.keymap.set(
            'v',
            '<leader>ad',
            '<cmd>CodeCompanionChat Add<CR>',
            { noremap = true, silent = true }
        )
    end,
}
