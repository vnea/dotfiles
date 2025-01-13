vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("clearjumps")
    end
})

-- Set filetype to yaml.ansible for .yml files in the /playbooks/ directory
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "*/roles/*.yml",
        "*/roles/*.yaml",
        "*/ansible/*.yml",
        "*/ansible/*.yaml",
    },
    command = "set filetype=yaml.ansible",
})
