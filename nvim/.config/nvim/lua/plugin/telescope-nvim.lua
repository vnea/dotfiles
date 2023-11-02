return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
        { "aaronhallaert/advanced-git-search.nvim" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("dap")
        telescope.load_extension("live_grep_args")
        require("telescope").load_extension("advanced_git_search")
        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    ".git",
                    ".idea",
                    "node_modules",
                },
            },
            extensions = {
                advanced_git_search = {
                    -- See Config
                }
            },
        })
    end,
}
