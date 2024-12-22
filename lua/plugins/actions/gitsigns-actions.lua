
local M = {}

function M.on_attach(bufnr)
    local gitsigns = require('gitsigns')

    -- navigation
    vim.keymap.set('n', '<leader>.'    , function()              -- move to next hunk
        gitsigns.nav_hunk('next')
    end)
    vim.keymap.set('n', '<leader>,'    , function()              -- move to previous hunk
        gitsigns.nav_hunk('prev')
    end)

    -- action
    vim.keymap.set('n', '<leader>p', gitsigns.preview_hunk)      -- preview diff where cursor is on
end

return M
