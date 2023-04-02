return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>c",  "<Plug>(comment_toggle_linewise_current)",  mode = "n", silent = true, noremap = true },
    { "<leader>bc", "<Plug>(comment_toggle_blockwise_current)", mode = "n", silent = true, noremap = true },
    { "<leader>c",  "<Plug>(comment_toggle_linewise_visual)",   mode = "x", silent = true, noremap = true },
    { "<leader>bc", "<Plug>(comment_toggle_blockwise_visual)",  mode = "x", silent = true, noremap = true },
  },
  config = true,
}
