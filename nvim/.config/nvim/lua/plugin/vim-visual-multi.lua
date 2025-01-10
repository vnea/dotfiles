return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        vim.g.VM_maps = {
            ["Find Under"]         = "<Leader>j",
            ["Find Subword Under"] = "<Leader>j",
            ["Select All"]         = "<Leader>J",
            ["Add Cursor Down"]    = "<Leader><Down>",
            ["Add Cursor Up"]      = "<Leader><Up>",
        }
    end,
}
