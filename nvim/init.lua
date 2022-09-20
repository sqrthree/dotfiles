-- Load vim settings.
require('settings.options')

-- Leader/Local leader mapping
local leader_map = function()
  vim.g.mapleader = ','
  vim.g.maplocalleader = ','
  vim.api.nvim_set_keymap('n', ' ', '', { noremap = true })
  vim.api.nvim_set_keymap('x', ' ', '', { noremap = true })

  require('settings.mapping')

  -- Load plugin keybindings.
  require('settings.keybinding')
end

-- Keybindings
leader_map()

-- Load plugins.
local load_plugins = function()
  local plugins = require('plugins')

  plugins.ensure_plugins()
  plugins.load_compile()
end

load_plugins()

-- Enable Solarized Colorscheme. Power by https://github.com/altercation/vim-colors-solarized
vim.cmd [[colorscheme solarized]]

