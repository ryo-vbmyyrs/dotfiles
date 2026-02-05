vim.keymap.set('n', '<leader>nd', function()
    require('noice').cmd('dismiss')
end)

return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    opts = {
        messages = {
            view_history = 'popup',
        },
        commands = {
            history = {
                view = 'split',
                opts = { enter = true, format = 'details' },
                filter = {
                    any = {
                        { event = 'notify' },
                        { error = true },
                        { warning = true },
                        { event = 'msg_show', kind = { '' } },
                        { event = 'lsp', kind = 'message' },
                    },
                },
            },
        },
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            hover = {
                enabled = true,
                view = nil,
                opts = {
                    border = {
                        style = 'rounded',
                        padding = { 0, 1 },
                    },
                    position = { row = 2, col = 2 },
                },
            },
            signature = {
                enabled = true,
                opts = {
                    border = {
                        style = 'rounded',
                    },
                },
            },
        },
    },
}
