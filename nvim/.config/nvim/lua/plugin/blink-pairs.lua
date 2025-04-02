return {
    "saghen/blink.pairs",
    version = '*', -- (recommended) only required with prebuilt binaries

    dependencies = "saghen/blink.download",
    event = "BufEnter",

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
        mappings = {
            enabled = true,
            pairs = {
                ['('] = ')',
                ['['] = ']',
                ['{'] = '}',
                ["'"] = { closing = "'", enter = false },
                ['"'] = { closing = '"', enter = false },
                ['`'] = { closing = '`', enter = false },
            },
        },
        highlights = {
            enabled = true,
            -- Update colors in "nvim/.config/nvim/lua/plugin/theme.lua"
            groups = {
                "BlinkPairsOne",
                "BlinkPairsTwo",
                "BlinkPairsThree",
                "BlinkPairsFour",
                "BlinkPairsFive",
                "BlinkPairsSix",
                "BlinkPairsSeven",
                "BlinkPairsEight",
                "BlinkPairsNine",
            },
            priority = 200,
            ns = vim.api.nvim_create_namespace("blink.pairs"),
        },
        debug = false,
    }
}
