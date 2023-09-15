return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
                    init_selection = "<C-w>",
                    node_incremental = "<C-w>",
                    node_decremental = "<C-S-w>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["<C-Down>"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["<C-Up>"] = "@function.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>s"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>S"] = "@parameter.inner",
                    },
                },
            },
        })
    end,
}
