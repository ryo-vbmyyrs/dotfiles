return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        sign = false,
        keywords = {
            FIX = { color = 'error' },
            TODO = { color = 'info' },
            HACK = { color = 'warning' },
            WARN = { color = 'warning' },
            PERF = { color = 'hint' },
            NOTE = { color = 'hint' },
            TEST = { color = 'test' },
        },
        highlight = {
            keyword = 'wide_bg',
            after = '',
        },
        colors = {
            error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
            warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
            info = { '#2593ff' },
            hint = { '#80c9aa' },
            default = { '#7C3AED' },
            test = { '#FF00FF' },
        },
    },
}
