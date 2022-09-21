local tools = {}
local config = require('plugins.tools.config')

tools['lewis6991/gitsigns.nvim'] = {
  opt = true,
  event = { 'BufReadPost', 'BufNewFile' },
  config = config.gitsigns,
}

return tools
