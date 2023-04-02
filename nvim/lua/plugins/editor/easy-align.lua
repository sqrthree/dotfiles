return {
  "junegunn/vim-easy-align",
  event = { "BufWinEnter", "BufNewFile" },
  cmd = "EasyAlign",
  keys = {
    { "ga", "<Plug>(EasyAlign)", mode = "n", silent = true, noremap = false },
    { "ga", "<Plug>(EasyAlign)", mode = "x", silent = true, noremap = false },
  },
}
