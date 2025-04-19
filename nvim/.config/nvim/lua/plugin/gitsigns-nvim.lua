return {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = function()
        require("gitsigns").setup({
            signs_staged_enable = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
                delay = 50,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "<leader>hn", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end)

                map("n", "<leader>hN", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end)

                -- Actions
                map("n", "<leader>hh", gitsigns.toggle_linehl)
                map("n", "<leader>hp", gitsigns.preview_hunk)

                map("n", "<leader>hs", gitsigns.stage_hunk)
                map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

                map("n", "<leader>hr", gitsigns.reset_hunk)
                map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

                map("n", "<leader>hd", gitsigns.diffthis)
                map("n", "<leader>hD", function() gitsigns.diffthis("~") end)
            end,
        })
    end,
}
