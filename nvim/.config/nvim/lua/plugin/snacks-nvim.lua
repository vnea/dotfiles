return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        -- dashboard = { enabled = true },
        -- explorer = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        -- lazygit = { enabled = true },
        picker = {
            enabled = true,
            matcher = {
                frecency = true,
            },
            preview = false,
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
                })
            end,
            desc = "File Picker",
        },
        { "<Leader>rc", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "☀", --[[ <C-S-l>, check Alacritt conf ]] function() Snacks.picker.buffers() end, desc = "Buffers" },
        -- git
        { "<Leader>b", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<Leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<Leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        -- search
        { "<C-h>", function() Snacks.picker.help() end, desc = "Help Pages" },
    },
}
