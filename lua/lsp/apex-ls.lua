vim.lsp.enable('apex_ls')
vim.lsp.config('apex_ls', {
    cmd = { 'java', '-jar', '/root/.local/share/nvim/mason/share/apex-language-server/apex-jorje-lsp.jar' },
    filetypes = { 'apex' },
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        apex = {
            enable_semantic_errors = true,
            enable_completion_statistics = true,
        }
    }
})
