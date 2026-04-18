return {
    'akinsho/toggleterm.nvim',
    keys = { '<leader>tt' },
    config = function()
        require('toggleterm').setup({
            size = 20,
            open_mapping = [[<leader>tt]],
            start_in_insert = true,
            insert_mappings = false,
            terminal_mappings = true,
            hide_numbers = true,
            shade_filetypes = {},
            autochdir = false,
            shade_terminals = true,
            persist_size = true,
            persist_mode = true,
            direction = 'horizontal',
            close_on_exit = true,
            clear_env = false,
            shell = vim.o.shell,
            auto_scroll = true,
            winbar = {
                enabled = false,
                name_formatter = function(term)
                    return term.name
                end,
            },
        })

        vim.api.nvim_set_keymap(
            'n',
            '<leader>ts',
            '<cmd>TermSelect<CR>',
            { noremap = true, silent = true }
        )

        vim.keymap.set('n', '<leader>tn', function()
            local newTerm = Terminal:new({})
            newTerm:toggle()
        end, { desc = 'Open new terminal' })
    end,
}
