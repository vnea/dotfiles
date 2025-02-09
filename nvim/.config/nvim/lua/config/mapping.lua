-- ======================
-- === General
-- ======================

vim.g.mapleader = " "

-- Escape
vim.keymap.set({ "i", "v" }, "jk", "<Esc>")
-- https://vi.stackexchange.com/questions/4919/exit-from-terminal-mode-in-neovim-vim-8#comment57834_4922
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true })

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

-- Open current window in another tab (to simulate Fullscreen mode)
vim.keymap.set("n", "<Leader>z", "<Cmd>tabedit %<CR>")
vim.keymap.set("n", "<Leader>=", "<Cmd>wincmd =<CR>")

-- Move lines, source: https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
vim.keymap.set("v", "<C-A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-A-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-A-Up>", ":m .-2<CR>==")
vim.keymap.set("i", "<C-A-Down>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-A-Up>", "<Esc>:m .-2<CR>==gi")

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
vim.keymap.set("n", "☃" --[[ <C-S-A-Left> --]], "<C-W><S-H>")
vim.keymap.set("n", "☄" --[[ <C-S-A-Right> --]], "<C-W><S-L>")
vim.keymap.set("n", "★" --[[ <C-S-A-Up> --]], "<C-W><S-k>")
vim.keymap.set("n", "☆" --[[ <C-S-A-Down> --]], "<C-W><S-J>")

-- ======================
-- === Text case
-- ======================
vim.keymap.set({ "n", "v" }, "<Leader>sc", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })

-- ======================
-- === File explorer (nvim-tree)
-- ======================
vim.keymap.set("n", "☇" --[[ <A-&> --]], "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "go", "<cmd>NvimTreeFindFile<CR>")

-- ======================
-- === Navigation
-- ======================
vim.keymap.set("n", "<Leader>F", function()
    require("fzf-lua").live_grep_glob({
        winopts     = {
            fullscreen = true,
            preview = {
                layout = "vertical",
            }
        },
        git_icons   = false,
        file_icons  = false,
        color_icons = false,
        resume      = true,
        rg_opts     = table.concat({
            "--hidden",
            "--column",
            "--line-number",
            "--no-heading",
            "--color=always",
            "--smart-case",
            "--max-columns=4096",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/node_modules/*",
            "--glob=!**/.venv/*",
            "--glob=!**/.vscode/*",
            "-e"
        }, " ")
    })
end)

-- ======================
-- === Scretch
-- ======================
vim.keymap.set("n", "<leader>sn", function() require("scretch").new_named() end)
vim.keymap.set("n", "<leader>sf", function() require("scretch").search() end)
vim.keymap.set("n", "<leader>sd", "<cmd>!rm -f ~/.config/nvim/scretch/*<CR>")

-- ======================
-- === Template
-- ======================
vim.keymap.set("n", "<leader>it", "<cmd>Telescope find_template type=insert<CR>")

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
vim.keymap.set("n", "<Leader>K", "<cmd>Git<CR>")
vim.keymap.set("n", "<Leader>al", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "<Leader>ar", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "<F7>", "]c")
vim.keymap.set("n", "<S-F7>", "[c")
vim.keymap.set("n", "<Leader>7", "<cmd>AdvancedGitSearch diff_commit_file<CR>")
vim.keymap.set("n", "<Leader>hf", "<cmd>AdvancedGitSearch diff_commit_file<CR>")
vim.keymap.set("n", "<Leader>8", "<cmd>AdvancedGitSearch diff_branch_file<CR>")
vim.keymap.set("n", "<Leader>hb", "<cmd>AdvancedGitSearch diff_branch_file<CR>")

-- ======================
-- === CopilotChat
-- ======================
vim.keymap.set("n", "<Leader>cp", "<Cmd>CopilotChatToggle<CR>")
vim.keymap.set("n", "<Leader>cP", function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end)
