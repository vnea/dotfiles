return {
    "karb94/neoscroll.nvim",
    opts = {},
    config = function()
        neoscroll = require('neoscroll')
        neoscroll.setup({
        })

        local keymap = {
            ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 75 }) end,
            ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 75 }) end,
        }
        local modes = { 'n', 'v', 'x' }
        for key, func in pairs(keymap) do
            vim.keymap.set(modes, key, func)
        end
    end,
}
