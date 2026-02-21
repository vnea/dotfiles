return {
    "epwalsh/obsidian.nvim",
    version = "*",
    cond = function()
        return string.find(vim.fn.getcwd(), "Obsidian Vault") ~= nil
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/Obsidian Vault",
            },
        },
    },
}
