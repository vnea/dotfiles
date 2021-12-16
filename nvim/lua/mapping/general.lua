local mapping = require("mapping.module")

-- Escape
mapping.inoremap("jj", "<Esc>")
mapping.vnoremap("jj", "<Esc>")

-- Save and exit
mapping.nnoremap("ZZ", ":x<CR>")
mapping.inoremap("ZZ", "<Esc>:x<CR>")
mapping.vnoremap("ZZ", "<Esc>:x<CR>")

-- Exit without change
mapping.inoremap("qq", "<Esc>:q!<CR>")
mapping.nnoremap("qq", ":q!<CR>")
