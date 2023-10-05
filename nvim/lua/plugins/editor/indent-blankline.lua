return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPost",
  dependencies = { "nvim-treesitter" },
  config = function()
    require("ibl").setup({
      indent = {
        char = { "╎", "╏", "┆", "┇", "┊", "┋" },
      },
    })
  end,
}
