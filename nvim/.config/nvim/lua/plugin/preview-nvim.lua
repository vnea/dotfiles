return {
    "https://gitlab.com/itaranto/preview.nvim",
    opts = {
        previewers_by_ft = {
            asciidoc = {
                name = "asciidoc_html",
                renderer = { type = "command", opts = { cmd = { "asciidoctor" } } },

            },
        },
    },
}
