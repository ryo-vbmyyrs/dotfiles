local ensure_install_languages = {
    'apex',
    'bash',
    'css',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'groovy',
    'hcl',
    'html',
    'html_tags',
    'java',
    'javadoc',
    'javascript',
    'jsdoc',
    'json',
    'jsx',
    'just',
    'kotlin',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'mermaid',
    'nix',
    'python',
    'ruby',
    'rust',
    'sflog',
    'soql',
    'sosl',
    'sql',
    'terraform',
    'tsx',
    'typescript',
    'vim',
    'xml',
    'yaml',
    'zig',
}

return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter').setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
        })

        require('nvim-treesitter').install(ensure_install_languages)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = vim.tbl_keys(require('nvim-treesitter.parsers')),
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
