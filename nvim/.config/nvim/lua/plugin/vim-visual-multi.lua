return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        vim.g.VM_maps = {
            ["Find Under"]         = "<A-j>",
            ["Find Subword Under"] = "<A-j>",
            ["Select All"]         = "<A-S-j>",
            ["Add Cursor Down"]    = "<Leader><Down>",
            ["Add Cursor Up"]      = "<Leader><Up>",
        }
    end,
}
