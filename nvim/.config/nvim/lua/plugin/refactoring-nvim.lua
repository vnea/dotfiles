return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("refactoring").setup()

        vim.keymap.set({ "n", "x" }, "<Leader>ev", "<cmd>Refactor extract_var<CR>")
        vim.keymap.set("x", "<Leader>ef", "<cmd>Refactor extract<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>iv", "<cmd>Refactor inline_var<CR>")
        vim.keymap.set("n", "<Leader>if", "<cmd>Refactor inline_func<CR>")
    end,
}
