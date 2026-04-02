return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local languages = {
            "bash",
            "css",
            "csv",
            "gitattributes",
            "gitignore",
            "go",
            "hcl",
            "html",
            "java",
            "javascript",
            "jinja",
            "json",
            "json5",
            "kitty",
            "lua",
            "markdown",
            "mermaid",
            "python",
            "query",
            "terraform",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "zsh",
        }

        require("nvim-treesitter").install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = languages,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
