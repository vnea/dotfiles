return {
    "MagicDuck/grug-far.nvim",
    config = function()
        require("grug-far").setup({
            keymaps = {
                applyNext = { n = "<enter>" },
            },
            engines = {
                ripgrep = {
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
    end
}
