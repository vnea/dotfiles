-- Source: https://github.com/epwalsh/obsidian.nvim/issues/286#issuecomment-1877391540
vim.opt.conceallevel = 1
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
