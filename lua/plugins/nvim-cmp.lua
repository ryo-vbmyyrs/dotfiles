-- gray
vim.api.nvim_set_hl(
    0,
    'CmpItemAbbrDeprecated',
    { bg = 'NONE', strikethrough = true, fg = '#808080' }
)
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp', lazy = true },
        { 'hrsh7th/cmp-nvim-lua', lazy = true },
        { 'hrsh7th/cmp-buffer', lazy = true },
        { 'hrsh7th/cmp-path', lazy = true },
        { 'hrsh7th/cmp-cmdline', lazy = true },
        { 'saadparwaiz1/cmp_luasnip', lazy = true },
        { 'L3MON4D3/LuaSnip', lazy = true },
        { 'onsails/lspkind-nvim', lazy = true },
        { 'brenoprata10/nvim-highlight-colors', lazy = true },
    },
    event = { 'VeryLazy' },
    config = function()
        local cmp = require('cmp')
        local types = require('cmp.types')
        vim.opt.completeopt = { 'menu', 'menuone' }
        -- 共通の設定
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = 'Normal:Pmenu,FloatBorder:RyoPmenuBorder,CursorLine:PmenuSel,Search:None',
                    border = 'double',
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = 'FloatBorder:RyoPmenuBorder',
                    border = 'rounded',
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end,
                ['<C-j>'] = cmp.mapping.select_next_item({
                    behavior = types.cmp.SelectBehavior.Insert,
                }),
                ['<C-k>'] = cmp.mapping.select_prev_item({
                    behavior = types.cmp.SelectBehavior.Insert,
                }),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'render-markdown' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            }),
            formatting = {
                format = function(entry, item)
                    local color_item =
                        require('nvim-highlight-colors').format(entry, { kind = item.kind })
                    item = require('lspkind').cmp_format({
                        mode = 'symbol',
                        preset = 'codicons',
                    })(entry, item)
                    if color_item.abbr_hl_group then
                        item.kind_hl_group = color_item.abbr_hl_group
                        item.kind = color_item.abbr
                    end
                    return item
                end,
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline({
                ['<C-j>'] = { c = cmp.mapping.select_next_item() },
                ['<C-k>'] = { c = cmp.mapping.select_prev_item() },
            }),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline({
                ['<C-j>'] = { c = cmp.mapping.select_next_item() },
                ['<C-k>'] = { c = cmp.mapping.select_prev_item() },
            }),
            sources = {
                { name = 'buffer' },
            },
        })
    end,
}
