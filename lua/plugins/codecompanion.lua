return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ravitemer/mcphub.nvim',
    },
    config = function()
        require('codecompanion').setup({
            strategies = {
                chat = {
                    adapter = {
                        name = 'copilot',
                        model = 'claude-sonnet-4',
                    },
                },
                inline = {
                    adapter = {
                        name = 'copilot',
                        model = 'claude-sonnet-4',
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
