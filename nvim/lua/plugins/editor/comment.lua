return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  keys = {
    -- Default mappings:
    -- `gcc` - Toggles the current line using linewise comment
    -- `gbc` - Toggles the current line using blockwise comment
    -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
    -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
    -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
    -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

    { "<leader>c",  "<Plug>(comment_toggle_linewise_current)",  mode = "n", silent = true, noremap = true },
    { "<leader>bc", "<Plug>(comment_toggle_blockwise_current)", mode = "n", silent = true, noremap = true },
    { "<leader>c",  "<Plug>(comment_toggle_linewise_visual)",   mode = "x", silent = true, noremap = true },
    { "<leader>bc", "<Plug>(comment_toggle_blockwise_visual)",  mode = "x", silent = true, noremap = true },
  },
}
