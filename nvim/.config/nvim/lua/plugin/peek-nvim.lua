return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        local peek = require("peek")
        peek.setup({
            app = "webview",
            close_on_bdelete = true,
            auto_load = true,
            syntax = false,
            update_on_change = true,

        })
        vim.keymap.set("n", "<leader>mP", function()
            if peek.is_open() then
                peek.close()
            else
                peek.open()
            end
        end)
    end,
}
