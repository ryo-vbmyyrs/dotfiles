local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal Mode --
-- Better window navigation
keymap('n', '<leader>h', '<C-w>h', opts)
keymap('n', '<leader>j', '<C-w>j', opts)
keymap('n', '<leader>k', '<C-w>k', opts)
keymap('n', '<leader>l', '<C-w>l', opts)

-- New Buffer
keymap('n', '<C-n>', ':ene<CR>', opts)

-- Split window
keymap('n', '<leader>sk', ':split<Return><C-w>w', opts)
keymap('n', '<leader>sl', ':vsplit<Return><C-w>w', opts)

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', opts)

-- カーソル移動
keymap('n', 'J', '10j', opts)
keymap('n', 'K', '10k', opts)
keymap('n', 'H', '0', opts)
keymap('n', 'L', '$', opts)

-- 行末までのヤンクにする
keymap('n', 'Y', 'y$', opts)

-- 空行を挿入
keymap('n', '<leader>o', 'o<Esc>', opts)
keymap('n', '<leader>O', 'O<Esc>', opts)

-- redo
keymap('n', 'rr', '<C-r>', opts)

-- search word cursor on
keymap('n', '*', '*Nzz', opts)

-- ウィンドウリサイズのキーマップ
vim.keymap.set('n', '<C-k>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-j>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-[>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-]>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equalize window sizes' })

-- Insert Mode --
-- Press jj fast to exit insert mode
keymap('i', 'jj', '<ESC>', opts)
-- to enter back slash in macOS
keymap('i', '<M-¥>', '\\', opts)

-- Visual Mode --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- カーソル移動
keymap('v', 'J', '10j', opts)
keymap('v', 'K', '10k', opts)
keymap('v', 'H', '0', opts)
keymap('v', 'L', '$h', opts)

-- 0番レジスタを使いやすくした
keymap('v', '<C-p>', '"0p', opts)

-- Terminal Mode
keymap('t', 'jj', '<C-\\><C-n>', term_opts)

local command_runner = require('config.command-runner')
vim.keymap.set('n', '<leader>cr', command_runner.run_command, { desc = 'Run saved command' })
vim.keymap.set('n', '<leader>ca', command_runner.add_command, { desc = 'Add command' })
