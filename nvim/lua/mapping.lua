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

-- Escape
inoremap("jk", "<Esc>")

-- Save and exit
inoremap("jj", "<Esc>:x<CR>")
nnoremap("jj", ":x<CR>")

-- Exit without change
inoremap("kk", "<Esc>:q!<CR>")
nnoremap("kk", ":q!<CR>")
