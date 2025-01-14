return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = {
                    "isort",
                    "black",
                    "flake8",
                },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        })
    end,
    opts = {}
}
