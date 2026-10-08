local ls = require('luasnip')

-- スニペットの設定
ls.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
})

require('luasnip.loaders.from_lua').lazy_load({
    paths = vim.fn.stdpath('config') .. '/lua/snippets',
})

ls.filetype_expand('typescriptreact', { 'typescript', 'javascript' })
ls.filetype_expand('javascriptreact', { 'javascript' })

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true, desc = 'LuaSnip: Expand or jump' })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true, desc = 'LuaSnip: jump back' })
