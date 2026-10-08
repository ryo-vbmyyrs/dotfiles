-- 言語サーバーを全て再起動するコマンド
vim.api.nvim_create_user_command('LspRestart', function()
    for _, c in ipairs(vim.lsp.get_clients()) do
        c:stop()
    end
    vim.cmd('e')
end, {})
