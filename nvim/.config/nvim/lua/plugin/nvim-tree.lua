return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            actions = {
                open_file = {
                    resize_window = false,
                },
            },
            diagnostics = {
                enable = true,
            },
            filters = {
                git_ignored = false,
                custom = {
                    ".vscode",
                    ".idea",
                },
            },
            hijack_directories = {
                enable = false,
            },
            view = {
                adaptive_size = true,
                side = "right",
            },
        })

        -- Source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#remember-nvimtree-window-size
        local remember_window_size = function()
            local view = require("nvim-tree.view")
            local api = require("nvim-tree.api")
            local augroup = vim.api.nvim_create_augroup
            local autocmd = vim.api.nvim_create_autocmd

            -- save nvim-tree window width on WinResized event
            augroup("save_nvim_tree_width", { clear = true })
            autocmd("WinResized", {
                group = "save_nvim_tree_width",
                pattern = "*",
                callback = function()
                    local filetree_winnr = view.get_winnr()
                    if filetree_winnr ~= nil and vim.tbl_contains(vim.v.event["windows"], filetree_winnr) then
                        vim.t["filetree_width"] = vim.api.nvim_win_get_width(filetree_winnr)
                    end
                end,
            })

            -- restore window size when openning nvim-tree
            api.events.subscribe(api.events.Event.TreeOpen, function()
                if vim.t["filetree_width"] ~= nil then
                    view.resize(vim.t["filetree_width"])
                end
            end)
        end
        remember_window_size()
    end,
}
