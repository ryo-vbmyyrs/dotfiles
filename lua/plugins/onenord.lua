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
                functions   = 'strikethrough',
                variables   = 'NONE',
                diagnostics = 'undercurl',
            },
            disable = {
                background = true,
            },
            custom_highlights = {
                MatchParen = { fg = colors.none, bg = colors.none, style = 'strikethrough,undercurl' },
            },
            custom_colors = {
                mypink = '#FFB2CC',
            },
        }
    end
}
