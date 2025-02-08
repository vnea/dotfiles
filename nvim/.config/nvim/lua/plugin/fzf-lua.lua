return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        require("fzf-lua").setup({
            keymap = {
                fzf = {
                    ["ctrl-o"] = "select-all+accept",
                },
            },
        })
    end
}
