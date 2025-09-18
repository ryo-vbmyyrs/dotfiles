local path = vim.fn.stdpath('data') .. '/mason/share/apex-language-server/apex-jorje-lsp.jar'

vim.lsp.config('apex_ls', {
    cmd = { 'java', '-jar', path },
    filetypes = { 'apex' },
    flags = {
        debounce_text_changes = 150,
    },
    root_markers = { 'sfdx-project.json' },
    settings = {
        apex = {
            enable_semantic_errors = true,
            enable_completion_statistics = true,
        },
    },
})
