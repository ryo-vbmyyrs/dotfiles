local path
if vim.fn.has('mac') then
    path = '~/.local/share/nvim/mason/share/apex-language-server/apex-jorje-lsp.jar'
else
    path = '~/AppData/nvim-data/mason/share/apex-language-server/apex-jorje-lsp.jar'
end

vim.lsp.config('apex_ls', {
    cmd = { 'java', '-jar', vim.fn.expand(path) },
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
