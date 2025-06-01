vim.o.background = 'dark'

return {
    "Mofiqul/vscode.nvim",
    config = function ()
        require('vscode').setup({
            italic_comments = false,
            underline_links = true,
            disable_nvimtree_bg = false,
            terminal_colors = true,
        })

        vim.cmd("colorscheme vscode")

        -- Re-apply custom highlight groups after colorscheme is set
        require('plugins.actions.colorscheme')
    end
}
