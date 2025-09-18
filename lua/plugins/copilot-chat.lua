
return {
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'zbirenbaum/copilot.lua' },
        },
        build = 'make tiktoken',
        config = function ()
            local default_prompts = require('CopilotChat.config.prompts')
            local in_japanese = 'なお、説明は日本語でお願いします。'

            require('CopilotChat').setup({
                debug = false,
                model = 'claude-sonnet-4',
                highlight_headers = false,
                window = {
                    layout = 'vertical',
                    width = 0.35,
                },
                prompts = vim.tbl_deep_extend('force', default_prompts, {
                    Explain = { prompt = default_prompts.Explain.prompt .. in_japanese},
                    Review = { prompt = default_prompts.Review.prompt .. in_japanese},
                    Fix = { prompt = default_prompts.Fix.prompt .. in_japanese},
                    Optimize = { prompt = default_prompts.Optimize.prompt .. in_japanese},
                    TranslateJE = {
                        prompt = 'Translate the selected text from English to Japanese if it is in English, or from Japanese to English if it is Japanese. Please do not include unnecessary line breaks, line numbers, comments, etc. in the result.',
                        system_prompt = 'You are an excellent Japanese-English translator. You can translate the original text correctly without losing its meaning. You also have deep knowledge of system engineering and are good at translating technical documents.',
                        description = 'Translate text from Japanese to English or vice versa',
                    },
                }),
            })
        end,
        keys = {
            {
                '<leader>aa',
                function ()
                    require('CopilotChat').toggle()
                end,
                desc = 'CopilotChat - Toggle',
            },
        },
    }
}
