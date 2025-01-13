-- nvim-tree configuration: https://github.com/nvim-tree/nvim-tree.lua#quick-start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Must be first because we define leader mapping here and Lazy needs it to be defined first
require("config.mapping")

require("config.autocmd")
require("config.command")
require("config.lazy")
require("config.option")
