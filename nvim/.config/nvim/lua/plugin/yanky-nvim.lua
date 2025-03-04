return {
    "gbprod/yanky.nvim",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        require("yanky").setup({
            highlight = {
                on_put = true,
                on_yank = true,
                timer = 100,
            },
            ring = {
                history_length = 0,
            },
        })

        vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
    end,
}
