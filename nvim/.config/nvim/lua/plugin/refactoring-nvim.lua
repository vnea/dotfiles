return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("refactoring").setup()

        vim.keymap.set({ "n", "x" }, "<leader>ev", "<cmd>Refactor extract_var<cr>")
        vim.keymap.set("x", "<leader>ef", "<cmd>Refactor extract<cr>")
        vim.keymap.set({ "n", "x" }, "<leader>iv", "<cmd>Refactor inline_var<cr>")
        vim.keymap.set("n", "<leader>if", "<cmd>Refactor inline_func<cr>")
    end,
}
