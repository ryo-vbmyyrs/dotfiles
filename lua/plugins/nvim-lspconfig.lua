vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

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

-- keymaps
vim.keymap.set('n', '[', '<cmd>lua vim.lsp.buf.hover()<CR>') -- show information where cursor on
vim.keymap.set('n', ']', '<cmd>lua vim.lsp.buf.definition()<CR>') -- jump to definition
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>') -- show list where the variable cursor on is referenced
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>') -- rename the variable

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
    version = '*',
    lazy = true,
    config = function() end,
}
