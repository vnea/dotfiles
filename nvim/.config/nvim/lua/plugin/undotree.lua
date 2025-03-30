return {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
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

        vim.keymap.set("n", "<Leader>u", undotree.toggle, { desc = "Toggle [U]ndotree" })
    end,
}
