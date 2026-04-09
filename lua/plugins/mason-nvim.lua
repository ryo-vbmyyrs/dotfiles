return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    event = 'VeryLazy',
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'jdtls', -- Java LSP
            },
        })
    end,
}
