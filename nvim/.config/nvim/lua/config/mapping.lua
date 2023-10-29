-- ======================
-- === General
-- ======================

vim.g.mapleader = " "

-- Escape
vim.keymap.set({ "i", "v" }, "jk", "<Esc>")

-- Save
vim.keymap.set("i", "ZZ", "<cmd>xa<CR>")

-- Exit without change
vim.keymap.set("i", "qq", "<esc><cmd>q!<CR>")
vim.keymap.set("n", "qq", "<cmd>q!<CR>")
vim.keymap.set("i", "QQ", "<esc><cmd>qa!<CR>")
vim.keymap.set("n", "QQ", "<cmd>qa!<CR>")

-- Delete/change without copying in clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "D", '"_D')
vim.keymap.set({ "n", "v" }, "c", '"_c')

-- Delete/change copying in clipboard
vim.keymap.set({ "n", "v" }, "<Leader>x", "x")
vim.keymap.set({ "n", "v" }, "<Leader>d", "d")
vim.keymap.set({ "n", "v" }, "<Leader>D", "D")
vim.keymap.set({ "n", "v" }, "<Leader>c", "c")

-- Page up/down but center cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>M")
vim.keymap.set("n", "<C-u>", "<C-u>M")

-- Join lines but let cursor at its original place
vim.keymap.set("n", "J", "mzJ`z")

-- Go to last opened buffer
vim.keymap.set("n", "<C-l>", "<Cmd>edit #<CR>")

-- Save
vim.keymap.set("n", "<C-s>", "<Cmd>wa<CR>")
vim.keymap.set("i", "<C-s>", "<Esc><Cmd>wa<CR>")

-- Show help tags
vim.keymap.set("n", "<C-h>", function() require("fzf-lua").help_tags({ winopts = { fullscreen = true } }) end)

-- ======================
-- === Window
-- ======================

-- Move
vim.keymap.set("n", "<A-Left>", "<C-W><Left>")
vim.keymap.set("n", "<A-Right>", "<C-W><Right>")
vim.keymap.set("n", "<A-Up>", "<C-W><Up>")
vim.keymap.set("n", "<A-Down>", "<C-W><Down>")

-- Resize
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize -5<CR>")
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +5<CR>")

-- Split
vim.keymap.set("n", "<A-v>", "<cmd>vertical split<CR>")
vim.keymap.set("i", "<A-v>", "<Esc><cmd>vertical split<CR>")
vim.keymap.set("n", "<A-h>", "<cmd>split<CR>")
vim.keymap.set("i", "<A-h>", "<Esc><cmd>split<CR>")

-- Swap
vim.keymap.set("n", "<C-S-A-Left>", "<C-W><S-H>")
vim.keymap.set("n", "<C-S-A-Right>", "<C-W><S-L>")
vim.keymap.set("n", "<C-S-A-Up>", "<C-W><S-k>")
vim.keymap.set("n", "<C-S-A-Down>", "<C-W><S-J>")

-- ======================
-- === Navigation
-- ======================
vim.keymap.set("n", "<C-n>", function()
    require("fzf-lua").files({
        fd_opts = "--type f --hidden --no-ignore --exclude .git --exclude .idea --exclude node_modules",
        cwd_prompt = false,
        prompt = "Files❯ ",
        winopts = { preview = { hidden = "hidden" } }
    })
end)
vim.keymap.set("n", "<C-S-l>", function() require("fzf-lua").buffers() end)
vim.keymap.set("n", "<Leader>F", function()
    require("fzf-lua").live_grep_glob({
        rg_opts = "--no-ignore --hidden --glob '!.git' --column --line-number --color=always --max-columns=4096 --regexp",
        continue_last_search = true,
        winopts = {
            fullscreen = true,
            preview    = {
                layout = "vertical",
                border = "noborder",
            }
        }
    })
end)

-- ======================
-- === LSP
-- ======================
vim.keymap.set("n", "<Leader><F2>", function() require("fzf-lua").diagnostics_document() end)
vim.keymap.set("n", "<Leader><S-F2>", function() require("fzf-lua").diagnostics_workspace() end)
vim.keymap.set("n", "gr", function() require("fzf-lua").lsp_references() end)
vim.keymap.set("n", "gd", function() require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end)
vim.keymap.set("n", "gi", function() require("fzf-lua").lsp_implementations({ jump_to_single_result = true }) end)
vim.keymap.set("n", "gs", function() require("fzf-lua").lsp_document_symbols() end)
vim.keymap.set("n", "<Leader><A-Enter>", function() require("fzf-lua").spell_suggest() end)

-- =====================
-- === Refactoring
-- ======================
vim.keymap.set({ "n", "x" }, "<Leader>ev", "<cmd>Refactor extract_var<CR>")
vim.keymap.set("x", "<Leader>ef", "<cmd>Refactor extract<CR>")
vim.keymap.set({ "n", "x" }, "<Leader>iv", "<cmd>Refactor inline_var<CR>")
vim.keymap.set("n", "<Leader>if", "<cmd>Refactor inline_func<CR>")

-- ======================
-- === Scretch
-- ======================
vim.keymap.set("n", "<leader>sn", function() require("scretch").new_named() end)
vim.keymap.set("n", "<leader>sf", function() require("scretch").search() end)
vim.keymap.set("n", "<leader>sd", "<cmd>!rm -f ~/.config/nvim/scretch/*<CR>")

-- ======================
-- === Dap
-- ======================
vim.keymap.set({ "n", "i" }, "<S-F9>", function() require("fzf-lua").dap_configurations() end)
vim.keymap.set({ "n", "i" }, "<F9>", function() require("dap").continue() end)
vim.keymap.set({ "n", "i" }, "<C-F2>", function() require("dap").terminate() end)
vim.keymap.set({ "n", "i" }, "<C-F8>", function() require("dap").toggle_breakpoint() end)
vim.keymap.set({ "n", "i" }, "<F8>", function() require("dap").step_over() end)
vim.keymap.set({ "n", "i" }, "<F7>", function() require("dap").step_into() end)
vim.keymap.set({ "n", "i" }, "<F6>", function() require("dap").step_out() end)
vim.keymap.set({ "n", "i" }, "<A-(>", function() require("dapui").toggle() end)


-- ======================
-- === Hop
-- ======================
vim.keymap.set("n", "<Leader>f", "<cmd>HopWord<CR>")

-- ======================
-- === Twilight
-- ======================
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Twilight<CR>")
