return {
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        terminal_colors = true,
      }
    end,
    config = function()
      vim.cmd[[colorscheme solarized-osaka]]
    end,
  },
}
