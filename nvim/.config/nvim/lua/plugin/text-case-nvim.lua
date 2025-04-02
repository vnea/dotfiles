return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  event = "InsertEnter",
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
}
