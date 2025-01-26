return {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("midnight").setup({
            SpellBad = {
                style = "underline",
            },
            SpellCap = {
                style = "underline",
            },
            SpellLocal = {
                style = "underline",
            },
            SpellRare = {
                style = "underline",
            },
        })
        vim.cmd.colorscheme "midnight"
    end,
}
