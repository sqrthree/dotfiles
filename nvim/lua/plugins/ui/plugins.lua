local ui = {}
local config = require('plugins.ui.config')

-- Theme
ui['altercation/vim-colors-solarized'] = {}

-- Statusline
ui['nvim-lualine/lualine.nvim'] = {
  opt = true,
  event = 'BufWinEnter',
  config = config.lualine,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

return ui
