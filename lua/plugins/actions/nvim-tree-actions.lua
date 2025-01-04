local menuCommand = {}

local function actionsMenu(nd)
    local default_options = {
        results_title = 'NvimTree',
        finder = require('telescope.finders').new_table {
            results = menuCommand,
            entry_maker = function(menu_item)
                return {
                    value = menu_item,
                    ordinal = menu_item.name,
                    display = menu_item.name,
                }
            end,
        },
        sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_buffer_number)
            local actions = require 'telescope.actions'

            -- On item select
            actions.select_default:replace(function()
                -- Closing the picker
                actions.close(prompt_buffer_number)
                -- Executing the callback
                require('telescope.actions.state').get_selected_entry().value.handler(nd)
            end)
            return true
        end,
    }

    -- Opening the menu
    require('telescope.pickers')
        .new({ prompt_title = 'Command', layout_config = { width = 0.3, height = 0.5 } }, default_options)
        :find()
end

local api = require 'nvim-tree.api'
local tree, fs, node = api.tree, api.fs, api.node

-- keymaps
local command = {
    { '',      node.open.replace_tree_buffer,  'Open: In Place' },
    { '',      node.show_info_popup,           'Info' },
    { '',      node.open.tab,                  'Open: New Tab' },
    { '',      node.open.vertical,             'Open: Vertical Split' },
    { '',      node.open.horizontal,           'Open: Horizontal Split' },
    { '<BS>',  node.navigate.parent_close,     'Close Directory' },
    { '<CR>',  node.open.edit,                 'Open' },
    { '<Tab>', node.open.preview,              'Open Preview' },
    { '>',     node.navigate.sibling.next,     'Next Sibling' },
    { '<',     node.navigate.sibling.prev,     'Previous Sibling' },
    { '.',     node.run.cmd,                   'Run Command' },
    { '[c',    node.navigate.git.prev,         'Prev Git' },
    { ']c',    node.navigate.git.next,         'Next Git' },
    { ']e',    node.navigate.diagnostics.next, 'Next Diagnostic' },
    { '[e',    node.navigate.diagnostics.prev, 'Prev Diagnostic' },
    { 'J',     node.navigate.sibling.last,     'Last Sibling' },
    { 'K',     node.navigate.sibling.first,    'First Sibling' },
    { 'o',     node.open.edit,                 'Open' },
    { 'O',     node.open.no_window_picker,     'Open: No Window Picker' },
    { 'P',     node.navigate.parent,           'Parent Directory' },
    { 's',     node.run.system,                'Run System' },
    { '',      tree.change_root_to_node,       'CD' },
    { '-',     tree.change_root_to_parent,     'Up' },
    { 'B',     tree.toggle_no_buffer_filter,   'Toggle No Buffer' },
    { 'C',     tree.toggle_git_clean_filter,   'Toggle Git Clean' },
    { 'E',     tree.expand_all,                'Expand All' },
    { 'W',     tree.collapse_all,              'Collapse All' },
    { 'g?',    tree.toggle_help,               'Help' },
    { 'H',     tree.toggle_hidden_filter,      'Toggle Dotfiles' },
    { 'I',     tree.toggle_gitignore_filter,   'Toggle Git Ignore' },
    { 'q',     tree.close,                     'Close' },
    { 'R',     tree.reload,                    'Refresh' },
    { 'S',     tree.search_node,               'Search' },
    { 'U',     tree.toggle_custom_filter,      'Toggle Hidden' },
    { '',      fs.create,                      'Create' },
    { 'D',     fs.remove,                      'Delete' },
    { 'Y',     fs.copy.node,                   'Copy' },
    { 'y',     fs.copy.filename,               'Copy Name' },
    { 'gy',    fs.copy.absolute_path,          'Copy Absolute Path' },
    { '',      fs.copy.relative_path,          'Copy Relative Path' },
    { '',      fs.cut,                         'Cut' },
    { 'p',     fs.paste,                       'Paste' },
    { '',      fs.trash,                       'Trash' },
    { 'r',     fs.rename,                      'Rename' },
    { '',      fs.rename_basename,             'Rename: Basename' },
    { '',      fs.rename_sub,                  'Rename: Omit Filename' },
    { '',      api.marks.bulk.move,            'Move Bookmarked' },
    { 'f',     api.live_filter.start,          'Filter start' },
    { 'F',     api.live_filter.clear,          'Filter end' },
    { 'm',     api.marks.toggle,               'Toggle Bookmark' },

    -- { '<2-LeftMouse>',  node.open.edit,        'Open' },

    { '<Space>', actionsMenu,                  'Command' },
}

local function createTreeActions()
    for _, cmd in pairs(command) do
        table.insert(menuCommand, { name = cmd[3], handler = cmd[2] })
    end
end

createTreeActions()

local M = {}

function M.on_attach(bufnr)
    local opts = function(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, nowait = true }
    end

    for _, cmd in pairs(command) do
        if (string.len(cmd[1]) > 0) then
            vim.keymap.set('n', cmd[1], cmd[2], opts(cmd[3]))
        end
    end
end

return M
