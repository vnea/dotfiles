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
            callback = function(args)
                local buf, filetype = args.buf, args.match

                local language = vim.treesitter.language.get_lang(filetype)
                if not language then return end

                if not vim.treesitter.language.add(language) then return end

                vim.treesitter.start(buf, language)
            end
        })
    end,
}
