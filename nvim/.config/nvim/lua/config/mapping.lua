-- ======================
-- === General
-- ======================

vim.g.mapleader = " "

-- Escape
vim.keymap.set({ "i", "v" }, "jk", "<Esc>")

-- Save
vim.keymap.set("i", "ZZ", "<cmd>xa<CR>")

-- Exit without change
vim.keymap.set("i", "qq", "<esc><cmd>q!<CR>")
vim.keymap.set("n", "qq", "<cmd>q!<CR>")
vim.keymap.set("i", "QQ", "<esc><cmd>qa!<CR>")
vim.keymap.set("n", "QQ", "<cmd>qa!<CR>")

-- Delete/change without copying in clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "D", '"_D')
vim.keymap.set({ "n", "v" }, "c", '"_c')

-- Delete/change copying in clipboard
vim.keymap.set({ "n", "v" }, "<Leader>x", "x")
vim.keymap.set({ "n", "v" }, "<Leader>d", "d")
vim.keymap.set({ "n", "v" }, "<Leader>D", "D")
vim.keymap.set({ "n", "v" }, "<Leader>c", "c")

-- Page up/down but center cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>M")
vim.keymap.set("n", "<C-u>", "<C-u>M")

-- Join lines but let cursor at its original place
vim.keymap.set("n", "J", "mzJ`z")

-- Go to last opened buffer
vim.keymap.set("n", "<C-l>", "<Cmd>edit #<CR>")

-- Save
vim.keymap.set("n", "<C-s>", "<Cmd>wa<CR>")
vim.keymap.set("i", "<C-s>", "<Esc><Cmd>wa<CR>")

-- Show help tags
vim.keymap.set("n", "<C-h>", function() require("telescope.builtin").help_tags() end)

-- Fzf command line history
vim.keymap.set({ "n", "v" }, "<Leader>r", function() require("telescope.builtin").command_history() end)

-- Open current window in another tab (to simulate Fullscreen mode)
vim.keymap.set("n", "<Leader>z", "<Cmd>tabedit %<CR>")
vim.keymap.set("n", "<Leader>=", "<Cmd>wincmd =<CR>")

-- ======================
-- === Window
-- ======================

-- Move
vim.keymap.set("n", "<A-Left>", "<C-W><Left>")
vim.keymap.set("n", "<A-Right>", "<C-W><Right>")
vim.keymap.set("n", "<A-Up>", "<C-W><Up>")
vim.keymap.set("n", "<A-Down>", "<C-W><Down>")

-- Resize
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize -5<CR>")
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +5<CR>")

-- Split
vim.keymap.set("n", "<A-v>", "<cmd>vertical split<CR>")
vim.keymap.set("i", "<A-v>", "<Esc><cmd>vertical split<CR>")
vim.keymap.set("n", "<A-h>", "<cmd>split<CR>")
vim.keymap.set("i", "<A-h>", "<Esc><cmd>split<CR>")

-- Swap
vim.keymap.set("n", "<C-S-A-Left>", "<C-W><S-H>")
vim.keymap.set("n", "<C-S-A-Right>", "<C-W><S-L>")
vim.keymap.set("n", "<C-S-A-Up>", "<C-W><S-k>")
vim.keymap.set("n", "<C-S-A-Down>", "<C-W><S-J>")

-- ======================
-- === Navigation
-- ======================
vim.keymap.set("n", "<C-n>", function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end)
vim.keymap.set("n", "<C-S-l>", function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<Leader>F", function()
    require("telescope").extensions.live_grep_args.live_grep_args({
        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        }
    })
end)

-- ======================
-- === LSP
-- ======================
vim.keymap.set("n", "<Leader><F2>", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end)
vim.keymap.set("n", "<Leader><S-F2>", function() require("telescope.builtin").diagnostics() end)
vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end)
vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions() end)
vim.keymap.set("n", "gi", function() require("telescope.builtin").lsp_implementations() end)
vim.keymap.set("n", "gs", function() require("telescope.builtin").lsp_document_symbols() end)
vim.keymap.set("n", "<Leader><A-Enter>", function() require("telescope.builtin").spell_suggest() end)

-- =====================
-- === Refactoring
-- ======================
vim.keymap.set({ "n", "x" }, "<Leader>ev", "<cmd>Refactor extract_var<CR>")
vim.keymap.set("x", "<Leader>ef", "<cmd>Refactor extract<CR>")
vim.keymap.set({ "n", "x" }, "<Leader>iv", "<cmd>Refactor inline_var<CR>")
vim.keymap.set("n", "<Leader>if", "<cmd>Refactor inline_func<CR>")

-- ======================
-- === Scretch
-- ======================
vim.keymap.set("n", "<leader>sn", function() require("scretch").new_named() end)
vim.keymap.set("n", "<leader>sf", function() require("scretch").search() end)
vim.keymap.set("n", "<leader>sd", "<cmd>!rm -f ~/.config/nvim/scretch/*<CR>")

-- ======================
-- === Dap
-- ======================
vim.keymap.set({ "n", "i" }, "<S-F9>", "<cmd>Telescope dap configurations<CR>")
vim.keymap.set({ "n", "i" }, "<F9>", function() require("dap").continue() end)
vim.keymap.set({ "n", "i" }, "<C-F2>", function() require("dap").terminate() end)
vim.keymap.set({ "n", "i" }, "<C-F8>", function() require("dap").toggle_breakpoint() end)
vim.keymap.set({ "n", "i" }, "<F8>", function() require("dap").step_over() end)
vim.keymap.set({ "n", "i" }, "<F7>", function() require("dap").step_into() end)
vim.keymap.set({ "n", "i" }, "<F6>", function() require("dap").step_out() end)
vim.keymap.set({ "n", "i" }, "<A-(>", function() require("dapui").toggle() end)

-- ======================
-- === Hop
-- ======================
vim.keymap.set("n", "<Leader>f", "<cmd>HopWord<CR>")

-- ======================
-- === Twilight
-- ======================
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Twilight<CR>")

-- ======================
-- === Git
-- ======================
vim.keymap.set("n", "<Leader>k", function()
    local lazygit = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        -- Enable full screen
        float_opts = {
            width = 9999,
            height = 9999,
        },
    })
    lazygit:toggle()
end)
vim.keymap.set("n", "<Leader>K", "<cmd>Git<CR>")
vim.keymap.set("n", "<Leader>al", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "<Leader>ar", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "<F7>", "]c")
vim.keymap.set("n", "<S-F7>", "[c")
vim.keymap.set("n", "<Leader>7", function() require("telescope.builtin").git_bcommits() end)
vim.keymap.set("n", "<C-b>", function() require("telescope.builtin").git_branches() end)
