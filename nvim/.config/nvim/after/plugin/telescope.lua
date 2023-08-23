local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>ff", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fb", builtin.buffers, { noremap = true, silent = true })

