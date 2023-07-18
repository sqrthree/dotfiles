return {
  "akinsho/bufferline.nvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        diagnostics = "nvim_lsp",
      },
    })
  end,
}
