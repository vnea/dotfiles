vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.spelllang = "fr,en"
vim.opt.spell = true
vim.api.nvim_command("set clipboard+=unnamedplus")

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.api.nvim_command("set nofoldenable")
