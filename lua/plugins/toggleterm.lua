return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup{
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
            direction = 'float',
            close_on_exit = true,
            clear_env = false,
            shell = vim.o.shell,
            auto_scroll = true,
            float_opts = {
                border = 'curved',
                winblend = 3,
                title_pos = 'center',
            },
            winbar = {
                enabled = false,
                name_formatter = function(term)
                    return term.name
                end
            },
        }
  
        -- ここでlazygitを開く設定を追加している
        local Terminal  = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  
        function _lazygit_toggle()
            lazygit:toggle()
        end
  
        vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
    end
}
