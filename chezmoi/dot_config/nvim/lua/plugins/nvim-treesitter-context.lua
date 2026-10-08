return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'VeryLazy' },
    config = function()
        require('treesitter-context').setup({
            multiline_threshold = 1,
        })

        vim.keymap.set('n', '<leader>cj', function()
            require('treesitter-context').go_to_context(vim.v.count1)
        end, { silent = true })
    end,
}
