return {
    "Sonicfury/scretch.nvim",
    event = "VeryLazy",
    config = function()
        require("scretch").setup {
            scretch_dir = vim.fn.stdpath("config") .. "/scretch/",
            split_cmd = "edit",
            backend = "telescope.builtin",
        }
    end,
}
