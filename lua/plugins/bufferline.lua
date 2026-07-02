-- keymaps
vim.keymap.set('n', 'gb', '<cmd>BufferLinePick<CR>') -- choose buffer by appearing character to open
vim.keymap.set('n', 'gd', '<cmd>BufferLinePickClose<CR>') -- choose buffer by appearing character to close
vim.keymap.set('n', '<C-l>', '<cmd>BufferLineCycleNext<CR>') -- move to next buffer (visual order)
vim.keymap.set('n', '<C-h>', '<cmd>BufferLineCyclePrev<CR>') -- move to previous buffer (visual order)
vim.keymap.set('n', '<A-l>', '<cmd>BufferLineMoveNext<CR>') -- reorder: move current buffer right
vim.keymap.set('n', '<A-h>', '<cmd>BufferLineMovePrev<CR>') -- reorder: move current buffer left
vim.keymap.set('n', '<leader>ql', '<cmd>BufferLineCloseRight<CR>') -- close all buffer right of current buffer
vim.keymap.set('n', '<leader>qh', '<cmd>BufferLineCloseLeft<CR>') -- close all buffer left of current buffer

return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        require('bufferline').setup({})
    end,
}
