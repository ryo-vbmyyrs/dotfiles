return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    version = '*',
    ft = { 'markdown', 'noice', 'copilot-chat' },
    opts = {
        file_types = { 'markdown', 'noice', 'copilot-chat' },
    },
}
