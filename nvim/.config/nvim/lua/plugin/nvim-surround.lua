return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})

        vim.keymap.set("n", '<leader>"', '<cmd>normal ysiw"<cr>')
        vim.keymap.set("n", "<leader>'", "<cmd>normal ysiw'<cr>")
        vim.keymap.set("n", '<leader>è', "<cmd>normal ysiw`<cr>")
    end,
}
