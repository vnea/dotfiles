return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            signs_staged_enable = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 50,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
        })
        vim.keymap.set("n", "<Leader>gb", gitsigns.toggle_current_line_blame)
        vim.keymap.set("n", "<leader>grh", gitsigns.reset_hunk)
        vim.keymap.set("n", "<leader>gdt", gitsigns.diffthis)
    end,
}
