local config = function()
  local initial = function(str)
    return str:sub(1, 1)
  end

  require("lualine").setup({
    options = {
      theme = "nightfox",
      fmt = string.lower,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = initial,
        }
      },
      lualine_c = {
        {
          "filename",
          path = 1,
        }
      },
    }
  })
end

return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "EdenEast/nightfox.nvim",
  },
  config = config,
}
