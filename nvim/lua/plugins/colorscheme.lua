return {
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = true,
        terminal_colors = true,
        dim_inactive = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      })

      vim.cmd.colorscheme("solarized-osaka")
    end,
  },
}
