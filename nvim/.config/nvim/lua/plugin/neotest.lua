return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")
            },
        })

        vim.keymap.set("n", "<leader>tr", require("neotest").run.run)
        vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end)
        vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)
        vim.keymap.set("n", "<leader>ts", require("neotest").summary.toggle)
    end,
}
