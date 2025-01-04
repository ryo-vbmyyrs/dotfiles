return {
    'rmehri01/onenord.nvim',
    version = "*",
    config = function()
        local colors = require('onenord.colors').load()

        require('onenord').setup {
            styles = {
                comments    = 'NONE',
                strings     = 'NONE',
                keywords    = 'NONE',
                functions   = 'bold',
                variables   = 'NONE',
                diagnostics = 'underline',
            },
            disable = {
                background = true,
            },
            custom_highlights = {
                MatchParen = { fg = colors.none, bg = colors.none, style = 'bold,underline' },
            },
            custom_colors = {
                mypink = '#FFB2CC',
            },
        }
    end
}
