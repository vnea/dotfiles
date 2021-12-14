local function inoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "i",
            lhs,
            rhs,
            { noremap = true }
    )
end

local function nnoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "n",
            lhs,
            rhs,
            { noremap = true }
    )
end

local function vnoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "v",
            lhs,
            rhs,
            { noremap = true }
    )
end

-- Escape
inoremap("jj", "<Esc>")
vnoremap("jj", "<Esc>")

-- Save and exit
nnoremap("ss", ":x<CR>")

-- Exit without change
inoremap("qq", "<Esc>:q!<CR>")
nnoremap("qq", ":q!<CR>")
