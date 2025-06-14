return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    version = '*',
    ft = { 'markdown', 'Avante', 'AvanteInput', 'noice' },
    opts = {
        file_types = { 'markdown', 'Avante', 'AvanteInput', 'noice' },
    },
}
