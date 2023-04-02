return {
  "easymotion/vim-easymotion",
  event = { "BufWinEnter", "BufNewFile" },
  keys = {
    { "s", "<Plug>(easymotion-s2)", mode = "n", silent = true, noremap = true },
    { "t", "<Plug>(easymotion-s2)", mode = "n", silent = true, noremap = true },
  },
  config = function()
    vim.api.nvim_set_var("EasyMotion_smartcase", 1)
  end,
}
