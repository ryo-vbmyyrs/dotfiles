-- keymaps
vim.keymap.set('n', '[',  '<cmd>lua vim.lsp.buf.hover()<CR>')       -- show information where cursor on
vim.keymap.set('n', ']',  '<cmd>lua vim.lsp.buf.definition()<CR>')  -- jump to definition
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')  -- show list where the variable cursor on is referenced
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')      -- rename the variable

return {
    "neovim/nvim-lspconfig",
    version = "*",
    lazy = false,
    config = function()
        local lspconfig = require('lspconfig')
    end,
}
