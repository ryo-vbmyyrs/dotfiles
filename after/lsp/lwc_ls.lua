return {
    cmd = {
        'node',
        vim.fn.stdpath('data')
            .. '/mason/packages/lwc-language-server/node_modules/@salesforce/lwc-language-server/bin/lwc-language-server.js',
        '--stdio',
    },
    filetypes = { 'html', 'javascript', 'typescript' },
}
