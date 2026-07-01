-- highlight text when yanked
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
    end,
})

-- Quickfixの<CR>で、nvim-treeなどの特殊ウィンドウにジャンプ先が奪われて
-- ファイルが開けない問題への対策。通常の編集ウィンドウを選んでから開く。
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function(ev)
        -- Quickfixを下ではなく右に縦分割で出す（toggletermの高さと干渉させないため）
        if vim.bo[ev.buf].buftype == 'quickfix' then
            vim.cmd('wincmd L')
            vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.35))
        end

        vim.keymap.set('n', '<CR>', function()
            local idx = vim.fn.line('.')
            local target
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= 'qf' then
                    target = win
                    break
                end
            end
            if target then
                vim.api.nvim_set_current_win(target)
            end
            vim.cmd(idx .. 'cc')
        end, { buffer = ev.buf, silent = true, desc = 'Quickfix: 通常ウィンドウで開く' })
    end,
})
