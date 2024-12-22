return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  defaults = {
      mappings = {
          -- insert mode
          i = {
              ['?'] = 'which_key',
          },
          -- normal mode
          n = {
              ['?'] = 'which_key',
          },
      },
      winblend = 20,
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fc', builtin.commands,  { desc = 'Telescope find commands' })
  end
}
