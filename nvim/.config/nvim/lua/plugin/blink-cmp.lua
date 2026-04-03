return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "1.*",
    opts = {
        sources = {
            providers = {
                path = {
                    opts = {
                        show_hidden_files_by_default = true,
                    },
                },
            },
        },
    },
    opts_extend = {
        "sources.default",
    },
}
