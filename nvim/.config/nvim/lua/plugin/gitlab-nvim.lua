return {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "stevearc/dressing.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    tag = "v3.3.11",
    build = function() require("gitlab.server").build(true) end,
    config = function()
        require("gitlab").setup({
            reviewer_settings = {
                diffview = {
                    imply_local = true,
                },
            },
            keymaps = {
                global = {
                    add_assignee = "glaa",
                    add_label = "glla",
                    choose_merge_request = "<leader>mra", -- Create a new MR for currently checked-out feature branch
                    create_mr = "<leader>mrc",            -- Create a new MR for currently checked-out feature branch
                    open_in_browser = "<leader>mrb",      -- Openthe URL of the MR in the default Internet browser
                    summary = "<leader>mrd",              -- Show the editable summary of the MR
                    pipeline = "glp",                     -- Show the pipeline status
                },
                discussion_tree = {
                    toggle_node = "<tab>",   -- Open or close the discussion
                    jump_to_reviewer = "gd", -- Jump to the comment location in the reviewer window
                    switch_view = "sv",      -- Toggle between the notes and discussions views
                },
            },
            create_mr = {
                delete_branch = true,
                squash = true,
            },
        })
    end,
}
