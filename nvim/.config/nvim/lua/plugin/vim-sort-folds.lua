return {
    "obreitwi/vim-sort-folds",
    config = function()
        vim.keymap.set("v", "gz", ":SortFolds<cr>")
        vim.g.sort_folds_ignore_case = 1
    end,
}
