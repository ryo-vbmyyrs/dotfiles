local options = {
    encoding = "utf-8",
    fileencoding = "utf-8",
    title = true,
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 2,
    conceallevel = 0,
    mouse = "a",
    showmode = false,
    showtabline = 2,
    smartindent = true,
    termguicolors = true,
    timeoutlen = 300,
    undofile = true,
    updatetime = 300,
    writebackup = true,
    cursorline = true, -- maybe delete later
    number = true,
    numberwidth = 4,
    signcolumn = "yes",
    winblend = 0,
    wildoptions = "pum",
    pumblend = 5,
    background = "dark",
    wrap = false,
    scrolloff = 8, -- カーソルの上下に少なくともこの数の行だけ表示する（カーソル行が端にならない）
    sidescrolloff = 8, -- scrolloffの左右版
    guifont = "monospace:h17",

    -- 自動補完
    completeopt = { "menuone", "noselect" },
    pumheight = 10,

    -- tab関連
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,

    -- 検索関連
    hlsearch = true,
    ignorecase = true,
    smartcase = true,

    -- ウィンドウの分割 :vsplit時のウィンドウ移動keymapのためfalseにしておく
    splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
    splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる

}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
