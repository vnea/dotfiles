return {
    "Sonicfury/scretch.nvim",
    requires = "nvim-telescope/telescope.nvim",
    config = function()
        require("scretch").setup {
            scretch_dir = vim.fn.stdpath("config") .. "/scretch/",
            split_cmd = "edit",
            backend = "fzf-lua"
        }
    end
}
