-- open File Tree when open
local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- disable netrw
vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)


return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
        mode = "n",
        "<C-n>",
        "<cmd>NvimTreeToggle<CR>",
        desc = "NvimTreeをトグルする"
    },
    {
        mode = "n",
        "<C-m>",
        "<cmd>NvimTreeFocus<CR>",
        desc = "NvimTreeにフォーカス"
    },
  },
  config = function()
    require("nvim-tree").setup {
      git = {
        enable = true,
        ignore = true,
      },
      view = {
          width = '20%'
      },
      renderer = {
          highlight_git = true,
          highlight_opened_files = 'name',
          icons = {
              glyphs = {
                  git = {
                      unstaged = '!', renamed = '→', untracked = '?', deleted = '✗', staged = '✓'
                  },
              },
          },
      },
      actions = {
          expand_all = {
              max_folder_discovery = 200,
              exclude = { '.git', 'target', 'build' },
          },
      },
      on_attach = require('plugins/actions/nvim-tree-actions').on_attach,
    }
  end,
}
