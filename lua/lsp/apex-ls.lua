vim.lsp.config('apex_ls', {
    cmd = { 'java', '-jar', vim.fn.expand('~/.local/share/nvim/mason/share/apex-language-server/apex-jorje-lsp.jar') },
    filetypes = { 'apex' },
    flags = {
        debounce_text_changes = 150,
    },
    root_markers = { 'sfdx-project.json' },
    settings = {
        apex = {
            enable_semantic_errors = true,
            enable_completion_statistics = true,
        }
    }
})
