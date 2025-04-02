-- ======================
-- === General
-- ======================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable build-in mappings
vim.api.nvim_del_keymap("n", "<C-W>d") -- Show diagnostics under the cursor
vim.api.nvim_del_keymap("n", "<C-W><C-D>") -- Show diagnostics under the cursor

-- Escape
vim.keymap.set({ "i", "v" }, "jk", "<Esc>")
-- https://vi.stackexchange.com/questions/4919/exit-from-terminal-mode-in-neovim-vim-8#comment57834_4922
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true })

-- Remove scroll
vim.keymap.set({ "n", "v" }, "<S-up>", "<nop>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<S-down>", "<nop>", { noremap = true })

-- Save
vim.keymap.set("i", "ZZ", "<cmd>xa<cr>")

-- Exit without change
vim.keymap.set("i", "qq", "<esc><cmd>q!<cr>")
vim.keymap.set("n", "qq", "<cmd>q!<cr>")
vim.keymap.set("i", "QQ", "<esc><cmd>qa!<cr>")
vim.keymap.set("n", "QQ", "<cmd>qa!<cr>")

-- Delete/change without copying in clipboard
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "D", '"_D')
vim.keymap.set({ "n", "v" }, "c", '"_c')

-- Delete/change copying in clipboard
vim.keymap.set({ "n", "v" }, "<leader>x", "x")
vim.keymap.set({ "n", "v" }, "<leader>d", "d")
vim.keymap.set({ "n", "v" }, "<leader>D", "D")
vim.keymap.set({ "n", "v" }, "<leader>c", "c")

-- Page up/down but center cursor in middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>M")
vim.keymap.set("n", "<C-u>", "<C-u>M")

-- Join lines but let the cursor at its original place
vim.keymap.set("n", "J", "mzJ`z")

-- Go to last opened buffer
vim.keymap.set("n", "<C-l>", "<cmd>edit #<cr>")

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>wa<cr>")
vim.keymap.set("i", "<C-s>", "<Esc><cmd>wa<cr>")

-- Resize all window to have the same size
vim.keymap.set("n", "<leader>=", "<cmd>wincmd =<cr>")

-- Move lines, source: https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
vim.keymap.set("v", "<C-A-down>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<C-A-up>", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "<C-A-down>", ":m .+1<cr>==")
vim.keymap.set("n", "<C-A-up>", ":m .-2<cr>==")
vim.keymap.set("i", "<C-A-down>", "<Esc>:m .+1<cr>==gi")
vim.keymap.set("i", "<C-A-up>", "<Esc>:m .-2<cr>==gi")

-- Spelling
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.spelling() end)

-- Tabs
vim.keymap.set("n", "tc", "<cmd>tabc<cr>", { desc = "[T]ab [C]lose" })
vim.keymap.set("n", "tn", "<cmd>tabnew<cr>", { desc = "[T]ab [N]ew" })

vim.keymap.set("n", "<leader>dt", function() vim.api.nvim_command(vim.wo.diff and "windo diffoff" or "windo diffthis") end, { desc = "Toggle [D]iff [T]his" })

-- Compare with clipboard
vim.keymap.set("n", "<leader>C", function()
    vim.cmd(string.format([[
      tabnew %%
      vsplit
      enew
      normal! P
      setlocal buftype=nowrite
      set filetype=%s
    ]], vim.bo.filetype))
end, { desc = "[C]ompare buffer with clipboard" })

vim.keymap.set("x", "<leader>C", function()
    vim.cmd(string.format([[
       execute "normal! \"xy"
       tabnew
       vsplit
       enew
       normal! P
       setlocal buftype=nowrite
       set filetype=%s
       execute "normal! \<C-w>\<C-w>"
       enew
       set filetype=%s
       normal! "xP
  ]], vim.bo.filetype, vim.bo.filetype))
end, { desc = "[C]ompare selection with clipboard" })

-- Toggle OFF/ON relative line number
vim.keymap.set("n", "<leader>n", function() vim.cmd("set relativenumber!") end)

-- Toggle OFF/ON wrap
vim.keymap.set("n", "<leader>w", function() vim.cmd("set wrap!") end)

-- ======================
-- === Window
-- ======================

-- Move
vim.keymap.set("n", "<A-left>", "<C-W><left>")
vim.keymap.set("n", "<A-right>", "<C-W><right>")
vim.keymap.set("n", "<A-up>", "<C-W><up>")
vim.keymap.set("n", "<A-down>", "<C-W><down>")

-- Resize
vim.keymap.set("n", "<C-S-left>", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "<C-S-right>", "<cmd>vertical resize +5<cr>")
vim.keymap.set("n", "<C-S-up>", "<cmd>resize -5<cr>")
vim.keymap.set("n", "<C-S-down>", "<cmd>resize +5<cr>")

-- Split
vim.keymap.set("n", "<A-v>", "<cmd>vertical split<cr>")
vim.keymap.set("i", "<A-v>", "<Esc><cmd>vertical split<cr>")
vim.keymap.set("n", "<A-h>", "<cmd>split<cr>")
vim.keymap.set("i", "<A-h>", "<Esc><cmd>split<cr>")

-- Swap
vim.keymap.set("n", "☃" --[[ <C-S-A-left> --]], "<C-W><S-H>")
vim.keymap.set("n", "☄" --[[ <C-S-A-right> --]], "<C-W><S-L>")
vim.keymap.set("n", "★" --[[ <C-S-A-up> --]], "<C-W><S-k>")
vim.keymap.set("n", "☆" --[[ <C-S-A-down> --]], "<C-W><S-J>")

-- ======================
-- === LSP
-- ======================
-- Source: https://medium.com/@vishakhpro2002/neovim-v10-setup-with-inlayhints-838a503b17dc (check "InlayHints" section)
vim.keymap.set("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end)

-- ======================
-- === Text case
-- ======================
vim.keymap.set({ "n", "v" }, "<leader>sc", "<cmd>TextCaseOpenTelescope<cr>", { desc = "Telescope" })

-- ======================
-- === File explorers
-- ======================
vim.keymap.set("n", "☇" --[[ <A-&> --]], "<cmd>Neotree position=float toggle<cr>")
vim.keymap.set("n", "go", "<cmd>Neotree reveal position=float toggle<cr>")

vim.keymap.set("n", "☈" --[[ <A-é> --]], function() MiniFiles.open() end)
vim.keymap.set("n", "gO", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)

-- ======================
-- === Navigation
-- ======================
vim.keymap.set("n", "<leader>F", function() require("grug-far").open() end, { desc = "[F]ind everywhere" })
vim.keymap.set("v", "<leader>F", function() require('grug-far').with_visual_selection() end, { desc = "[F]ind visual everywhere" })

-- ======================
-- === Scretch
-- ======================
vim.keymap.set("n", "<leader>sn", function() require("scretch").new_named() end)
vim.keymap.set("n", "<leader>sf", function() require("scretch").search() end)
vim.keymap.set("n", "<leader>sd", "<cmd>!rm -f ~/.config/nvim/scretch/*<cr>")

-- ======================
-- === Template
-- ======================
vim.keymap.set("n", "<leader>it", "<cmd>Telescope find_template type=insert<cr>")

-- ======================
-- === Hop
-- ======================
vim.keymap.set("n", "<leader>f", "<cmd>HopWord<cr>")

-- ======================
-- === Git
-- ======================
vim.keymap.set("n", "<C-k>", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>al", "<cmd>diffget //2<cr>")
vim.keymap.set("n", "<leader>ar", "<cmd>diffget //3<cr>")
vim.keymap.set("n", "<F7>", "]c")
vim.keymap.set("n", "<S-F7>", "[c")
vim.keymap.set("n", "<leader>hf", "<cmd>AdvancedGitSearch diff_commit_file<cr>")
vim.keymap.set("n", "<leader>hb", "<cmd>AdvancedGitSearch diff_branch_file<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>")

-- ======================
-- === CopilotChat
-- ======================
vim.keymap.set("n", "<leader>cp", "<cmd>CopilotChatToggle<cr>")
vim.keymap.set("n", "<leader>cP", "<cmd>CopilotChatPrompts<cr>")
vim.keymap.set("v", "<leader>cP", ":CopilotChatPrompts<cr>")
