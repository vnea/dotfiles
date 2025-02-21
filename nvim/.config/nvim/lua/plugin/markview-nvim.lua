return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        require("markview").setup({
            preview = {
                enable = false,
            },
        })
        vim.keymap.set("n", "<Leader>mp", "<Cmd>Markview Toggle<CR>")
    end
}
