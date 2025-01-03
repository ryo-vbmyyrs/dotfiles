-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated'  , { bg='NONE', strikethrough=true, fg='#808080' })
-- blue                                         
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch'       , { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy'  , { link='CmpIntemAbbrMatch' })
-- light blue                                   
vim.api.nvim_set_hl(0, 'CmpItemKindVariable'    , { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface'   , { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText'        , { link='CmpItemKindVariable' })
-- pink                                         
vim.api.nvim_set_hl(0, 'CmpItemKindFunction'    , { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod'      , { link='CmpItemKindFunction' })
-- front                                        
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword'     , { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty'    , { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit'        , { link='CmpItemKindKeyword' })



return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind-nvim",
    },
    config = function()
        local cmp = require("cmp")
        local types = require('cmp.types')
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end,
                ['<C-j>']     = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
                ['<C-k>']     = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
                ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
                ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                ["<CR>"]      = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
            formatting = {
                format = require('lspkind').cmp_format({
                    mode = 'symbol',
                    preset = 'codicons',
                }),
            },
        })
    end
}
