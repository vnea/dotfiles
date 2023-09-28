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
-- === Telescope
-- ======================
vim.keymap.set("n", "<C-S-n>", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>",  function() require("telescope.builtin").git_files({ show_untracked = true }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-l>", function() require("telescope.builtin").buffers({ cwd_only = true, sort_mru = true }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f", function() require("telescope.builtin").live_grep() end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", function() require("telescope.builtin").help_tags() end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader><F2>", function() require("telescope.builtin").diagnostics() end, { noremap = true, silent = true })
vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end, { noremap = true, silent = true })
vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions() end, { noremap = true, silent = true })
vim.keymap.set("n", "gi", function() require("telescope.builtin").lsp_implementations() end, { noremap = true, silent = true })

-- ======================
-- === Refactoring
-- ======================
vim.keymap.set({"n", "x"}, "<Leader>ev", "<cmd>Refactor extract_var<CR>", { noremap = true, silent = true })
vim.keymap.set("x", "<Leader>ef", "<cmd>Refactor extract<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>iv", "<cmd>Refactor inline_var<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>if", "<cmd>Refactor inline_func<CR>", { noremap = true, silent = true })
