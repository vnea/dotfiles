local mapping = require("mapping.module")

-- Resize
mapping.nnoremap("<C-S-Left>", ":vertical resize -5<CR>")
mapping.nnoremap("<C-S-Right>", ":vertical resize +5<CR>")
mapping.nnoremap("<C-S-Up>", ":resize -5<CR>")
mapping.nnoremap("<C-S-Down>", ":resize +5<CR>")

-- Split
mapping.nnoremap("<A-v>", ":vertical split<CR>")
mapping.nnoremap("<A-h>", ":split<CR>")

-- Swap
mapping.nnoremap("<C-S-A-Left>", "<C-W><S-H>")
mapping.nnoremap("<C-S-A-Right>", "<C-W><S-L>")
mapping.nnoremap("<C-S-A-Up>", "<C-W><S-k>")
mapping.nnoremap("<C-S-A-Down>", "<C-W><S-J>")
