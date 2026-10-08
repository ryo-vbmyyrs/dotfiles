-- cmd / filetypes / root_markers / codeLens / hint などは nvim-lspconfig の
-- ベース設定 (lsp/lua_ls.lua) が提供する。Neovim API やプラグインの型 (library) は
-- lazydev.nvim が動的に注入する。ここではベースにも lazydev にも無い差分だけ上書きする。
return {
    settings = {
        Lua = {
            -- Neovim は LuaJIT なので明示 (lazydev は version を設定しない)
            runtime = { version = 'LuaJIT' },
        },
    },
}
