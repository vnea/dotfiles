return {
    "declancm/maximize.nvim",
    config = true,
    keys = {
        { "<Leader>z", function() require("maximize").toggle() end }
    },
}
