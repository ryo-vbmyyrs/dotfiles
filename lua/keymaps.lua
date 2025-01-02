local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',



-- Normal Mode --
-- Better window navigation
keymap("n", "<leader>wh", "<C-w>h", opts)
keymap("n", "<leader>wj", "<C-w>j", opts)
keymap("n", "<leader>wk", "<C-w>k", opts)
keymap("n", "<leader>wl", "<C-w>l", opts)

-- New tab
keymap("n", "<C-n>", ":tabnew<CR>", opts)

-- move tab
keymap("n", "<C-h>", "gT", opts) -- to left
keymap("n", "<C-l>", "gt", opts) -- to right

-- Split window
keymap("n", "<leader>sk", ":split<Return><C-w>w", opts)
keymap("n", "<leader>sl", ":vsplit<Return><C-w>w", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- カーソル移動
keymap("n", "J", "10j", opts)
keymap("n", "K", "10k", opts)
keymap("n", "H", "0", opts)
keymap("n", "L", "$", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- 空行を挿入
keymap("n", "<leader>o", "o<Esc>", opts)
keymap("n", "<leader>O", "O<Esc>", opts)

-- redo
keymap("n", "rr", "<C-r>", opts)

-- search word cursor on
keymap("n", "*", "*Nzz", opts)



-- Insert Mode --
-- Press jj fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)



-- Visual Mode --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- カーソル移動
keymap("v", "J", "10j", opts)
keymap("v", "K", "10k", opts)
keymap("v", "H", "0", opts)
keymap("v", "L", "$h", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)



-- Terminal Mode
keymap("t", "jj", "<C-\\><C-n>", term_opts)
