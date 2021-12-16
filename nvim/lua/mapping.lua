local map_options = {
    noremap = true,
    silent = true,
}

local function inoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "i",
            lhs,
            rhs,
            map_options
    )
end

local function nnoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "n",
            lhs,
            rhs,
            map_options
    )
end

local function vnoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "v",
            lhs,
            rhs,
            map_options
    )
end

-- Escape
inoremap("jj", "<Esc>")
vnoremap("jj", "<Esc>")

-- Save and exit
nnoremap("ZZ", ":x<CR>")
inoremap("ZZ", "<Esc>:x<CR>")
vnoremap("ZZ", "<Esc>:x<CR>")

-- Exit without change
inoremap("qq", "<Esc>:q!<CR>")
nnoremap("qq", ":q!<CR>")

-- Resize window
nnoremap("<C-S-Left>", ":vertical resize -5<CR>")
nnoremap("<C-S-Right>", ":vertical resize +5<CR>")
nnoremap("<C-S-Up>", ":resize -5<CR>")
nnoremap("<C-S-Down>", ":resize +5<CR>")

-- Split window
nnoremap("<A-v>", ":vertical split<CR>")
nnoremap("<A-h>", ":split<CR>")

-- Swap window
nnoremap("<C-S-A-Left>", "<C-W><S-H>")
nnoremap("<C-S-A-Right>", "<C-W><S-L>")
nnoremap("<C-S-A-Up>", "<C-W><S-k>")
nnoremap("<C-S-A-Down>", "<C-W><S-J>")

-- fzf
nnoremap("<C-n>", ":Files<CR>")
