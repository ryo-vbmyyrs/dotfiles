-- keymaps
vim.keymap.set('n', '[',  '<cmd>lua vim.lsp.buf.hover()<CR>')       -- show information where cursor on
vim.keymap.set('n', ']',  '<cmd>lua vim.lsp.buf.definition()<CR>')  -- jump to definition
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')  -- show list where the variable cursor on is referenced
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')      -- rename the variable

-- diagnostics (See `:h vim.diagnostic.config`)
vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
})
vim.cmd([[
    highlight DiagnosticUnderlineError gui=undercurl
    highlight DiagnosticUnderlineWarn gui=undercurl
    highlight DiagnosticUnderlineInfo gui=undercurl
    highlight DiagnosticUnderlineHint gui=undercurl
]])
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)         -- open diagnostic in float

return {
    "neovim/nvim-lspconfig",
    version = "*",
    lazy = false,
    config = function()
        local lspconfig = require('lspconfig')
    end,
}
