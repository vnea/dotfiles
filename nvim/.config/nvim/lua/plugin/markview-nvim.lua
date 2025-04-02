return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        require("markview").setup({
            preview = {
                enable = false,
            },
        })
        vim.keymap.set("n", "<leader>mp", "<cmd>Markview Toggle<cr>")
    end
}
