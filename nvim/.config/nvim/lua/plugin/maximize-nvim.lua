return {
    "declancm/maximize.nvim",
    config = true,
    keys = {
        { "<leader>z", function() require("maximize").toggle() end }
    },
}
