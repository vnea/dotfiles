local default_keymap_options = {
    noremap = true,
    silent = true,
}

-- ======================
-- === General
-- ======================

vim.g.mapleader = " "

-- Escape
vim.keymap.set({"i", "v"}, "jk", "<Esc>", default_keymap_options)

-- Exit without change
vim.keymap.set("i", "qq", "<esc><cmd>q!<CR>", default_keymap_options)
vim.keymap.set("n", "qq", "<cmd>q!<CR>", default_keymap_options)

-- Delete without yanking
vim.keymap.set({"n", "v"}, "x", '"_x', default_keymap_options)
vim.keymap.set({"n", "v"}, "<C-y>", '"_dd', default_keymap_options)

-- ======================
-- === Nvim-tree
-- ======================

vim.keymap.set("n", "<A-&>", "<cmd>NvimTreeToggle<CR>", default_keymap_options)
vim.keymap.set("n", "<A-é>", "<cmd>NvimTreeFindFile<CR>", default_keymap_options)

-- ====================
-- === Telescope
-- ====================

vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope git_files<CR>", default_keymap_options)
vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", default_keymap_options)
vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", default_keymap_options)

-- ======================
-- === Window
-- ======================

-- Move
vim.keymap.set("n", "<A-Left>", "<C-W><Left>", default_keymap_options)
vim.keymap.set("n", "<A-Right>", "<C-W><Right>", default_keymap_options)
vim.keymap.set("n", "<A-Up>", "<C-W><Up>", default_keymap_options)
vim.keymap.set("n", "<A-Down>", "<C-W><Down>", default_keymap_options)

-- Resize
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", default_keymap_options)
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", default_keymap_options)
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize -5<CR>", default_keymap_options)
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +5<CR>", default_keymap_options)

-- Split
vim.keymap.set("n", "<A-v>", "<cmd>vertical split<CR>", default_keymap_options)
vim.keymap.set("n", "<A-h>", "<cmd>split<CR>", default_keymap_options)

-- Swap
vim.keymap.set("n", "<C-S-A-Left>", "<C-W><S-H>", default_keymap_options)
vim.keymap.set("n", "<C-S-A-Right>", "<C-W><S-L>", default_keymap_options)
vim.keymap.set("n", "<C-S-A-Up>", "<C-W><S-k>", default_keymap_options)
vim.keymap.set("n", "<C-S-A-Down>", "<C-W><S-J>", default_keymap_options)

