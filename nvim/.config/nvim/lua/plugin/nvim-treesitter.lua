return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed      = {
                "bash",
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "query",
                "terraform",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            modules               = {},
            sync_install          = false,
            auto_install          = true,
            highlight             = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            ignore_install        = {},
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-w>",
                    node_incremental = "<C-w>",
                    node_decremental = "♠", -- <C-S-w>
                },
            },
            indent                = {
                enable = true
            },
            textobjects           = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["as"] = "@assignment.outer",
                        ["is"] = "@assignment.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    -- goto_next_start = {
                    --     ["<C-Down>"] = "@function.outer",
                    -- },
                    -- goto_previous_start = {
                    --     ["<C-Up>"] = "@function.outer",
                    -- },
                },
            },
        })
    end,
}
