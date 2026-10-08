-- nvim-cmp の capabilities を全サーバー共通で適用する。
-- LspAttach (サーバー起動) より前に設定する必要があるため、nvim-cmp の config では
-- なくここ (起動時) で設定する。
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- 大半のサーバーは mason-lspconfig の automatic_enable が自動で vim.lsp.enable する。
-- jsonls は schemastore.lua、jdtls は nvim-jdtls 側で扱う。
-- apex_ls は Mason レジストリに lspconfig 名の宣言が無く自動 enable 対象外なので手動で。
vim.lsp.enable('apex_ls')
