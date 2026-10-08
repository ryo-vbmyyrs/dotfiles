return {
    'numToStr/Comment.nvim',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = function()
        return {
            ignore = '^$',
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    end,
    keys = {
        {
            '<leader>c',
            '<Plug>(comment_toggle_linewise_current)',
            mode = 'n',
        },
        {
            '<leader>c',
            '<Plug>(comment_toggle_linewise_visual)',
            mode = 'v',
        },
    },
}
