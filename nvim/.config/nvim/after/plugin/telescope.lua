local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader><C-n>", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", function() builtin.git_files({ show_untracked = true }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f", builtin.live_grep, { noremap = true, silent = true })
