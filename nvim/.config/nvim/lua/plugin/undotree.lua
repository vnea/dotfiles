return {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
        local undotree = require("undotree")
        undotree.setup({
            window = {
                winblend = 0,
            },
            keymaps = {
                ["n"] = "move_next",
                ["N"] = "move_prev",
            },
        })

        if vim.fn.has("persistent_undo") == 1 then
            local persistent_undodir_folder = vim.fn.expand("~/dotfiles/nvim/.config/nvim/undodir")

            if vim.fn.isdirectory(persistent_undodir_folder) == 0 then
                vim.fn.mkdir(persistent_undodir_folder, "p", "0700")
            end

            vim.o.undodir = persistent_undodir_folder
            vim.o.undofile = true
        end

        vim.keymap.set("n", "<leader>u", undotree.toggle, { desc = "Toggle [U]ndotree" })

        vim.keymap.set("n", "<leader>cu", function()
            local confirm = vim.fn.confirm("Clear all undo history?", "&Yes\n&No", 2)
            if confirm == 1 then
                vim.cmd("!rm -rf ~/dotfiles/nvim/.config/nvim/undodir/*")
                print("Undo history cleared")
            end
        end, { desc = "Clear undo directory" })
    end,
}
