return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})

        vim.keymap.set("n", '<leader>"', '<cmd>normal ysiw"<CR>')
        vim.keymap.set("n", "<leader>'", "<cmd>normal ysiw'<CR>")
        vim.keymap.set("n", '<leader>è', "<cmd>normal ysiw`<CR>")
    end,
}
