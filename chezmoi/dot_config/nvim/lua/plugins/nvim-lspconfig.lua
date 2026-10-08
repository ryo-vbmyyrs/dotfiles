vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        -- 定義ジャンプ (gd は bufferline、grt は型定義なので gD を使う)
        vim.keymap.set(
            'n',
            'gD',
            vim.lsp.buf.definition,
            { buffer = bufnr, desc = 'LSP: jump to definition' }
        )
        -- ホバーは組み込みの K が keymaps.lua の K=10k と衝突するため gh を使う。
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: hover' })

        -- カーソル上の変数のハイライト
        if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup('DocumentHighlight', { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

            vim.api.nvim_create_autocmd('CursorHold', {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- diagnostics (See `:h vim.diagnostic.config`)
vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    float = {
        border = 'rounded',
    },
})
vim.cmd([[
    highlight DiagnosticUnderlineError gui=undercurl
    highlight DiagnosticUnderlineWarn gui=undercurl
    highlight DiagnosticUnderlineInfo gui=undercurl
    highlight DiagnosticUnderlineHint gui=undercurl
]])
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float) -- open diagnostic in float

return {
    'neovim/nvim-lspconfig',
    lazy = true,
    config = function() end,
}
