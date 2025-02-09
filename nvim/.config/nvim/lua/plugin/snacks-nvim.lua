return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- bigfile = { enabled = true },
        -- dashboard = { enabled = true },
        -- explorer = { enabled = true },
        -- indent = { enabled = true },
        -- input = { enabled = true },
        picker = {
            enabled = true,
            matcher = {
                frecency = true,
            },
        },
        -- notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- scope = { enabled = true },
        -- scroll = { enabled = true },
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
    ---@module "snacks"
    keys = {
        -- Pickers
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
    },
}
