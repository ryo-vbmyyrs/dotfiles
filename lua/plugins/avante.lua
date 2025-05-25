return {
    "yetone/avante.nvim",
    version = false, -- Never set this value to "*"! Never!
    dependencies = {
        -- required
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- optional
        "zbirenbaum/copilot.lua", -- for provider = "copilot"
    },
    opts = {
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        copilot = {
            model = "claude-3.7-sonnet",
        },
        behaviour = {
            auto_suggesions = false,
            auto_set_highlight_group = true,
        },
        mappings = {
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            cancel = {
                normal = { "<C-c>", "<Esc>", "q" },
                insert = { "<C-c>" },
            },
            sidebar = {
                apply_all = "A",
                apply_cursor = "a",
                retry_user_request = "r",
                edit_user_request = "e",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
                remove_file = "d",
                add_file = "@",
                close = { "<Esc>", "q" },
                close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
            },
        },
        hints = { enabled = true },
        windows = {
            position = "right",
            width = 30,
            sidebar_header = {
              enabled = true,
              align = "center",
              rounded = true,
            },
            input = {
              prefix = "> ",
              height = 8, -- Height of the input window in vertical layout
            },
            edit = {
              border = "rounded",
              start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
              floating = false,
              start_insert = true, -- Start insert mode when opening the ask window
              border = "rounded",
            },
        },
        highlights = {
            diff = {
                current = "DiffText",
                incoming = "DiffAdd",
            },
        },
    },
}

