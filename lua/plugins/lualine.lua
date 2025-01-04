return {
    'nvim-lualine/lualine.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'SmiteshP/nvim-navic',
    },
    config = function()
        require('lualine').setup {
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diagnostics'},
                lualine_c = {'filename', 'navic'},
                lualine_x = {'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        }
    end
}
