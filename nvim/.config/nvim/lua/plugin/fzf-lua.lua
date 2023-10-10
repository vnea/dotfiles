return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({
            -- Option: https://github.com/ibhagwan/fzf-lua#default-options
        })
    end
}
