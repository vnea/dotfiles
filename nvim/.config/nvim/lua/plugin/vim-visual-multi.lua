return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        vim.g.VM_maps = {
            ["Find Under"]         = "☁", -- <Cmd-j>
            ["Find Subword Under"] = "☁", -- <Cmd-j>
            ["Select All"]         = "☂", -- <Cmd-S-j>
            ["Add Cursor Down"]    = "<Leader><Down>",
            ["Add Cursor Up"]      = "<Leader><Up>",
        }
    end,
}
