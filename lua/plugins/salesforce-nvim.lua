return {
    'jonathanmorris180/salesforce.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('salesforce').setup {
            debug = {
                to_file = false,
                to_command_line = false,
            },
            popup = {
                width = 100,
                height = 20,
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
            file_manager = {
                ignore_conflicts = false,
            },
            org_manager = {
                default_org_indicator = '✓',
            },
        }
    end
}
