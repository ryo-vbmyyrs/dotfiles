return {
    cmd = {
        'node',
        vim.fn.stdpath('data')
            .. '/mason/packages/lwc-language-server/node_modules/@salesforce/lwc-language-server/bin/lwc-language-server.js',
        '--stdio',
    },
    filetypes = { 'html', 'javascript', 'typescript' },
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { 'sfdx-project.json' })
        if root then
            on_dir(root)
        end
    end,
}
