return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.1",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
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
        })
    end
}
