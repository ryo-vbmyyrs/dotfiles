local M = {}

-- lewis6991/gitsigns.nvim 公式推奨キーマップ準拠
-- https://github.com/lewis6991/gitsigns.nvim#keymaps
function M.on_attach(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
        else
            gitsigns.nav_hunk('next')
        end
    end)

    map('n', '[c', function()
        if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
        else
            gitsigns.nav_hunk('prev')
        end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk) -- stage hunk (ステージ済みならトグルで解除)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)

    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    -- 使わないため無効化
    -- map('n', '<leader>hb', function()
    --     gitsigns.blame_line({ full = true })
    -- end)

    -- diffthis は場面ごとに引数(リビジョン)を変えるため :Gitsigns diffthis {rev} で使う
    -- map('n', '<leader>hd', gitsigns.diffthis)
    -- map('n', '<leader>hD', function()
    --     gitsigns.diffthis('~')
    -- end)

    -- 使わないため無効化
    -- map('n', '<leader>hQ', function()
    --     gitsigns.setqflist('all')
    -- end)
    -- map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    -- 使わないため無効化
    -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    -- map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
end

return M
