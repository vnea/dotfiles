return {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
    event = "VeryLazy",
    opts = {
        keymaps = {
            ["<leader>sl"] = "swap_with_left",
            ["<leader>sr"] = "swap_with_right",
            ["<leader>sL"] = "swap_with_left_with_opp",
            ["<leader>sR"] = "swap_with_right_with_opp",
        },
    },
}
