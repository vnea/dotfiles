return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local gwidth = vim.api.nvim_list_uis()[1].width
        local gheight = vim.api.nvim_list_uis()[1].height
        local width = 60
        local height = 30

        require("nvim-tree").setup({
            diagnostics = { enable = true },
            filters = {
                git_ignored = false,
                custom = {
                    ".vscode",
                    ".idea",
                },
            },
            view = {
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                    -- To center the window, source: https://www.reddit.com/r/neovim/comments/wvcz64/comment/ioctmxc/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
                    open_win_config = {
                        relative = "editor",
                        width = width,
                        height = height,
                        row = (gheight - height) * 0.4,
                        col = (gwidth - width) * 0.5,
                    }
                },
            },
        })
    end,
}
