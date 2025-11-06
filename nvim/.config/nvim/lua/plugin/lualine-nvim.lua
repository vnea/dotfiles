return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                disabled_filetypes = {
                    "NvimTree",
                },
                globalstatus = true,
                theme = "auto",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
        })
    end,
}
