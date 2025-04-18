vim.opt.number = true

vim.opt.expandtab = true
vim.opt.tabstop = 4

vim.opt.shiftwidth = 4
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.spelllang = "fr,en"
vim.opt.spell = true
vim.o.switchbuf = "useopen"
vim.o.winborder = "rounded"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.listchars = { lead = "·", trail = "·", tab = "→ " }
vim.api.nvim_command("set clipboard+=unnamedplus")

-- Source: https://www.reddit.com/r/neovim/comments/12gfkmg/comment/jfkc7kb/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
