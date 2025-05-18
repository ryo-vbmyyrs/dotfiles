return {
    "williamboman/mason.nvim",
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    },
    version = "*",
    lazy = false,
    config = function()
        require("mason").setup()

        require('mason-lspconfig').setup({
            function(server_name)
                vim.lsp.enable(server_name)
            end,
        })
    end,
}
