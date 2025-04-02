return {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
        require("diffview").setup({
            default_args = {
                DiffviewOpen = { "--imply-local" },
            },
            enhanced_diff_hl = true,
        })
    end,
}
