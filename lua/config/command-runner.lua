local M = {}

local config_path = vim.fn.stdpath('config') .. '/commands.json'

function M.load_commands()
    local file = io.open(config_path, 'r')
    if not file then
        vim.notify('commands.json not found', vim.log.levels.ERROR)
        return {}
    end

    local content = file:read('*all')
    file:close()

    local ok, data = pcall(vim.json.decode, content)
    if not ok then
        vim.notify('Failed to parse commands.json', vim.log.levels.ERROR)
        return {}
    end

    return data.commands or {}
end

function M.run_command()
    local commands = M.load_commands()

    require('telescope.pickers')
        .new({}, {
            prompt_title = 'Run Command',
            finder = require('telescope.finders').new_table({
                results = commands,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry.name,
                        ordinal = entry.name,
                    }
                end,
            }),
            sorter = require('telescope.config').values.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
                local actions = require('telescope.actions')
                local action_state = require('telescope.actions.state')

                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    vim.cmd('split | terminal ' .. selection.value.command)
                end)

                return true
            end,
        })
        :find()
end

function M.add_command()
    vim.ui.input({ prompt = 'Command name: ' }, function(name)
        if not name or name == '' then
            return
        end

        vim.ui.input({ prompt = 'Command: ' }, function(command)
            if not command or command == '' then
                return
            end

            local commands = M.load_commands()
            table.insert(commands, {
                name = name,
                command = command,
                type = 'shell',
            })

            local file = io.open(config_path, 'w')
            if file then
                file:write(vim.json.encode({ commands = commands }))
                file:close()
                vim.notify('Command added: ' .. name, vim.log.levels.INFO)
            end
        end)
    end)
end

return M
