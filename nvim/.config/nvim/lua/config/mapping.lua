-- ======================
-- === General
-- ======================

vim.g.mapleader = " "

-- Escape
vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { noremap = true, silent = true })

-- Exit without change
vim.keymap.set("i", "qq", "<esc><cmd>q!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "qq", "<cmd>q!<CR>", { noremap = true, silent = true })

-- Delete/change without copying in clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, silent = true })

-- Delete/change copying in clipboard
vim.keymap.set({ "n", "v" }, "<Leader>x", "x", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>d", "d", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>D", "D", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>c", "c", { noremap = true, silent = true })

-- Page up/down but center cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>M", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>M", { noremap = true, silent = true })

-- Join lines but let cursor at its original place
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true })

-- Go to last opened buffer
vim.keymap.set("n", "<C-l>", "<Cmd>edit #<CR>", { noremap = true, silent = true })

-- Save
vim.keymap.set("n", "<C-s>", "<Cmd>wa<CR>", { noremap = true })

-- ======================
-- === Window
-- ======================

-- Move
vim.keymap.set("n", "<A-Left>", "<C-W><Left>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", "<C-W><Right>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", "<C-W><Up>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", "<C-W><Down>", { noremap = true, silent = true })

-- Resize
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +5<CR>", { noremap = true, silent = true })

-- Split
vim.keymap.set("n", "<A-v>", "<cmd>vertical split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-h>", "<cmd>split<CR>", { noremap = true, silent = true })

-- Swap
vim.keymap.set("n", "<C-S-A-Left>", "<C-W><S-H>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-A-Right>", "<C-W><S-L>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-A-Up>", "<C-W><S-k>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-A-Down>", "<C-W><S-J>", { noremap = true, silent = true })

-- ======================
-- === fzf-lua
-- ======================
vim.keymap.set("n", "<C-n>", function () require("fzf-lua").files({
    cwd_prompt = false,
    prompt = "Files❯ ",
    fd_opts = "--type f --hidden --no-ignore --exclude .git --exclude .idea --exclude node_modules",
    winopts = { preview = { hidden = "hidden" } }
}) end)
vim.keymap.set("n", "<C-S-l>", function () require("fzf-lua").buffers() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f", function () require("fzf-lua").live_grep_glob({
    winopts = {
        fullscreen = true,
        preview    = {
            layout   = "vertical",
            border   = "noborder",
        }
    }
}) end)
vim.keymap.set("n", "<C-h>", function () require("fzf-lua").help_tags({ winopts = { fullscreen = true } }) end)
vim.keymap.set("n", "<Leader><F2>", function () require("fzf-lua").diagnostics_document() end)
vim.keymap.set("n", "<Leader><S-F2>", function () require("fzf-lua").diagnostics_workspace() end)
vim.keymap.set("n", "gr", function () require("fzf-lua").lsp_references() end)
vim.keymap.set("n", "gd", function () require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end)
vim.keymap.set("n", "gi", function () require("fzf-lua").lsp_implementations({ jump_to_single_result = true }) end)
vim.keymap.set("n", "gs", function () require("fzf-lua").lsp_document_symbols() end)

-- ======================
-- === Refactoring
-- ======================
vim.keymap.set({ "n", "x" }, "<Leader>ev", "<cmd>Refactor extract_var<CR>", { noremap = true, silent = true })
vim.keymap.set("x", "<Leader>ef", "<cmd>Refactor extract<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>iv", "<cmd>Refactor inline_var<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>if", "<cmd>Refactor inline_func<CR>", { noremap = true, silent = true })

-- ======================
-- === Scretch
-- ======================
vim.keymap.set("n", "<leader>sn", function() require("scretch").new_named() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sf", function() require("scretch").search() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sd", "<cmd>!rm -f ~/.config/nvim/scretch/*<CR>", { noremap = true, silent = true })

-- ======================
-- === Dap
-- ======================
vim.keymap.set({ "n", "i" }, "<S-F9>", function () require("fzf-lua").dap_configurations() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<F9>", function() require("dap").continue() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<C-F2>", function() require("dap").terminate() end, { noremap = true })
vim.keymap.set({ "n", "i" }, "<C-F8>", function() require("dap").toggle_breakpoint() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<F8>", function() require("dap").step_over() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<F7>", function() require("dap").step_into() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<F6>", function() require("dap").step_out() end, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<A-(>", function() require("dapui").toggle() end, { noremap = true, silent = true })
