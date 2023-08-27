return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.1",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "go",
                "lua",
                "markdown",
                "vim",
                "vimdoc",
                "query",
                "json",
                "yaml",
                "javascript",
                "typescript",
                "html"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    scope_incremental = "<CR>",
                    node_incremental = "<TAB>",
                    node_decremental = "<S-TAB>",
                },
            },
        })
    end,
}
