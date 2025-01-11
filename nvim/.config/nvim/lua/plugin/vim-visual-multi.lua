return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        vim.g.VM_maps = {
            ["Find Under"]         = "☁", -- <Cmd-j>, check Alacritty conf
            ["Find Subword Under"] = "☁", -- <Cmd-j>, check Alacritty conf
            ["Select All"]         = "☂", -- <Cmd-S-j>, check Alacritty conf
            ["Add Cursor Down"]    = "<Leader><Down>",
            ["Add Cursor Up"]      = "<Leader><Up>",
        }
    end,
}
