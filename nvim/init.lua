local g = vim.g

-- Disable some builtin vim plugins
local default_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'tutor',
  'rplugin',
  'syntax',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  'ftplugin',
}

for _, plugin in pairs(default_plugins) do
  g['loaded_' .. plugin] = 1
end

-- Skip some remote provider loading
local default_providers = {
  'node',
  'perl',
  'python3',
  'ruby',
}

for _, provider in ipairs(default_providers) do
  g['loaded_' .. provider .. '_provider'] = 0
end

-- Load vim settings.
require('settings.options')

-- Load neovode related settings only in Neovide.
-- Document: https://neovide.dev/configuration.html
if g.neovide then
  require('settings.neovide')
end

-- Leader/Local leader mapping
local leader_map = function()
  g.mapleader = ','
  g.maplocalleader = ','
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
-- vim.cmd("colorscheme solarized")
-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme nightfox")
