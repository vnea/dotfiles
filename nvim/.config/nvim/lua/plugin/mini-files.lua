return {
    "echasnovski/mini.files",
    version = false,
    config = function()
        require("mini.files").setup()

        vim.keymap.set("n", "☈" --[[ <A-é> --]], require("mini.files").open)
    end,
}
