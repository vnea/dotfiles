return {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
    config = function()
        -- Options: https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
        require("grug-far").setup({
            keymaps = {
                applyNext = { n = "<enter>" },
            },
            engines = {
                ripgrep = {
                    extraArgs = table.concat({
                        "--hidden",
                        "--glob=!**/.git/*",
                        "--glob=!**/.idea/*",
                        "--glob=!**/node_modules/*",
                        "--glob=!**/.venv/*",
                        "--glob=!**/.vscode/*",
                    }, " "),
                    placeholders = {
                        search = "",
                        replacement = "",
                        filesFilter = "*.lua   *.{css,js}   **/docs/*.md",
                        flags = "--help --ignore-case (-i) --replace= (empty replace) --multiline (-U)",
                        paths = "/foo/bar   ../   ./hello\\ world/   ./src/foo.lua   ~/.config",
                    },
                },
            },
            windowCreationCommand = "tab split",
        })
    end,
}
