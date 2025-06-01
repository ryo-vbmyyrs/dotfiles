return {
    "williamboman/mason.nvim",
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    version = "*",
    event = 'VeryLazy',
    config = function()
        require("mason").setup()
        require('mason-lspconfig').setup()
    end,
}
