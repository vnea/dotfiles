-- ======================
-- === General
-- ======================

vim.g.mapleader = " "

-- Escape
vim.keymap.set({"i", "v"}, "jk", "<Esc>", { noremap = true, silent = true })

-- Exit without change
vim.keymap.set("i", "qq", "<esc><cmd>q!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "qq", "<cmd>q!<CR>", { noremap = true, silent = true })

-- Delete without yanking
vim.keymap.set({"n", "v"}, "x", '"_x', { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<C-y>", '"_dd', { noremap = true, silent = true })

-- Page up/down but center cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>M")
vim.keymap.set("n", "<C-u>", "<C-u>M")

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

