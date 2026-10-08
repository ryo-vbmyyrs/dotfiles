return {
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            background_colour = '#1e1e1e',
        })
    end,
}
