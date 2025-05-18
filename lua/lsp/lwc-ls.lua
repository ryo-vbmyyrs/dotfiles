vim.lsp.config('lwc_ls', {
    cmd = {
        'node',
        '/path/to/node_modules/@salesforce/lwc-language-server/bin/lwc-language-server.js',
        '--stdio'
    }
})
