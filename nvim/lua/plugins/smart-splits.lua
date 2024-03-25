return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup({
      at_edge = "stop",
    })
  end,
}
