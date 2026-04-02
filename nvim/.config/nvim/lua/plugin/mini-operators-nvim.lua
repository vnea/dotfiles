return {
  "echasnovski/mini.operators",
  config = function()
    require("mini.operators").setup({
      replace = {
        -- Hack to disable else it conflicts will "gr" LSP mapping
        prefix = " ",
      },
    })
  end,
}
