local M = {}

local map_options = {
    noremap = true,
    silent = true,
}

function M.inoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "i",
            lhs,
            rhs,
            map_options
    )
end

function M.nnoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "n",
            lhs,
            rhs,
            map_options
    )
end

function M.vnoremap(lhs, rhs)
    vim.api.nvim_set_keymap(
            "v",
            lhs,
            rhs,
            map_options
    )
end

return M
