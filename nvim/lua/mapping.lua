local function inoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "i",
            lhs,
            rhs,
            { noremap = true }
    )
end

inoremap("jk", "<Esc>")
