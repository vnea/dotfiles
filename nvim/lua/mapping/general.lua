local mapping = require("mapping.module")

-- Escape
mapping.inoremap("jj", "<Esc>")
mapping.vnoremap("jj", "<Esc>")

-- Exit without change
mapping.inoremap("qq", "<Esc>:q!<CR>")
mapping.nnoremap("qq", ":q!<CR>")
