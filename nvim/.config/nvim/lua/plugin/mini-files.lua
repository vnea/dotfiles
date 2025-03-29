return {
    "echasnovski/mini.files",
    version = false,
    config = function()
        require("mini.files").setup({
            options = {
                permanent_delete = false,
                use_as_default_explorer = false,
            },
            mappings = {
                go_in  = "<Tab>",
                go_out = "<S-Tab>",
            },
        })

        vim.keymap.set("n", "☈" --[[ <A-é> --]], require("mini.files").open)
    end,
}
