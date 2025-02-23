return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "aaronhallaert/advanced-git-search.nvim" },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close
                    },
                },
                file_ignore_patterns = {
                    "^.git/",
                    "^.idea/",
                    "$node_modules/",
                    "$.venv/",
                },
            },
            extensions = {
                advanced_git_search = {
                    diff_plugin = "diffview",
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("dap")
        telescope.load_extension("advanced_git_search")
        telescope.load_extension("find_template")
        telescope.load_extension("textcase")
    end,
}
