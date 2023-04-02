-- This theme is only used by lualine plugin for now.
return {
  "EdenEast/nightfox.nvim",
  lazy = true,
  config = function()
    require("nightfox").setup({
      transparent = true,
      dim_inactive = true,
    })

    -- load the colorscheme here
    -- vim.cmd("colorscheme nightfox")
  end,
}
