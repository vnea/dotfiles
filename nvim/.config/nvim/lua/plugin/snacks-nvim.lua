return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        -- explorer = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        -- lazygit = { enabled = true },
        picker = {
            enabled = true,
            matcher = {
                frecency = true,
            },
            formatters = {
                file = {
                    truncate = 200,
                },
            },
        },
        -- notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- scope = { enabled = true },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 15, total = 100 },
                easing = "linear",
            },
            -- faster animation when repeating scroll after delay
            animate_repeat = {
                delay = 100, -- delay in ms before using the repeat animation
                duration = { step = 5, total = 50 },
                easing = "linear",
            },
        },
        statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
    ---@module "snacks"
    ---@diagnostic disable-next-line: missing-fields
    keys = {
        -- ======================
        -- Module: picker
        -- ======================

        -- Top Pickers & Explorer
        {
            "<C-n>",
            function()
                Snacks.picker.files({
                    finder = "files",
                    format = "file",
                    show_empty = true,
                    hidden = true,
                    ignored = true,
                    follow = false,
                    supports_live = true,
                    exclude = {
                        ".git/",
                        ".idea/",
                        ".vscode/",
                        "node_modules/",
                        ".venv",
                        ".terraform",
                    },
                    layout = {
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        preview = false,
                    },
                })
            end,
            desc = "File Picker",
        },
        { "<leader>rc", function() Snacks.picker.command_history() end, desc = "Command History" },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { "☀", --[[ <C-S-l>, check Alacritty conf ]] function() Snacks.picker.buffers({ layout = { preview = false } }) end, desc = "Buffers" },

        -- Git
        { "<leader>b", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },

        -- Search
        { "<leader>H", function() Snacks.picker.help() end, desc = "Help Pages" },
    },
}
