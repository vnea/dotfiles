return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            custom_highlights = function(colors)
                return {
                    DiffAdd = { bg = "#15633b" },
                    DiffChange = { bg = "#15633b" },
                    DiffText = { bg = "#199c59" },
                    DiffDelete = {
                        bg = "#3F0001",
                        fg = "#520001",
                    },
                    Folded = { bg = "#2e2e47" },
                    UfoFoldedEllipsis = {
                        fg = colors.lavender,
                        bg = "#2e2e47",
                    },
                }
            end
        })
        vim.opt.fillchars:append("diff:╱")
        vim.cmd("colorscheme catppuccin-mocha")
    end,
}
