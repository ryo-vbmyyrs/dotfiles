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
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diagnostics' },
                lualine_c = {
                    { 'filename', path = 1 },
                    'navic',
                },
                lualine_x = { 'filetype' },
                lualine_y = { 'searchcount' },
                lualine_z = { 'location' },
            },
            options = {
                globalstatus = true,
                component_separators = { left = '', right = '' },
            },
        }
    end
}
