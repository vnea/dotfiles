return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        vim.g.VM_maps = {
            ["Find Under"]      = "<A-j>",
            ["Add Cursor Down"] = "",
            ["Add Cursor Up"]   = "",
        }
    end,
}
