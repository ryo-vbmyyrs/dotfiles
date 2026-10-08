return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    opts = {
        -- Mason で自動インストールするサーバー (lspconfig 名)。
        -- apex_ls は Mason レジストリに lspconfig 名の宣言が無く、ここでは
        -- 扱えないため :Mason から手動でインストールする。
        ensure_installed = {
            'cssls',
            'gopls',
            'html',
            'jdtls',
            'jsonls',
            'lua_ls',
            'lwc_ls',
            'marksman',
            'nil_ls',
            'pylsp',
            'terraformls',
            'ts_ls',
            'zls',
        },
        -- インストール済みサーバーを自動で vim.lsp.enable する。
        -- jdtls は nvim-jdtls が独自に起動するため除外。
        -- stylua は `stylua --lsp` でフォーマット用 LSP として起動できるが、Lua の整形は
        -- none-ls 経由の stylua で行っているため、二重のフォーマット提供元になるのを避けて除外。
        automatic_enable = {
            exclude = { 'jdtls', 'stylua' },
        },
    },
}
