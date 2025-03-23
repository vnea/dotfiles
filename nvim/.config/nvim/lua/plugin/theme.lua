return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            custom_highlights = function(colors)
                return {
                    DiffAdd = { bg = "#013601" },
                    DiffChange = { bg = "#013601" },
                    DiffText = { bg = "#017d40" },
                    DiffDelete = { bg = "#3F0001" },

                    Folded = { bg = "#2e2e47" },
                    UfoFoldedEllipsis = {
                        fg = colors.lavender,
                        bg = "#2e2e47",
                    },

                    -- Colors come from here: https://plugins.jetbrains.com/plugin/10080-rainbow-brackets
                    BlinkPairsOne = { fg = "#fdd370" },
                    BlinkPairsTwo = { fg = "#c4e993" },
                    BlinkPairsThree = { fg = "#8fdcff" },
                    BlinkPairsFour = { fg = "#c892e7" },
                    BlinkPairsFive = { fg = "#f18d71" },
                    BlinkPairsSix = { fg = "#a4bd29" },
                    BlinkPairsSeven = { fg = "#0060a0" },
                    BlinkPairsEight = { fg = "#d17424" },
                    BlinkPairsNine = { fg = "#f9c26c" },
                }
            end
        })
        vim.opt.fillchars:append("diff:╱")
        vim.cmd("colorscheme catppuccin-mocha")
    end,
}
