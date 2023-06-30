return {
  "ggandor/leap.nvim",
  event = { "BufWinEnter", "BufNewFile" },
  config = function()
    require("leap").add_default_mappings()
  end,
}
