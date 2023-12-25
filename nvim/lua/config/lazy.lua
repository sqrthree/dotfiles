local data_dir = require("constants.global").data_dir

local plugin_dir = data_dir .. "/lazy"
local lazypath = plugin_dir .. "/lazy.nvim"

-- Bootstrap lazy.nvim:
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- For information on how to setup Lazy.nvim, please see
-- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
require("lazy").setup({
  root = plugin_dir,
  defaults = {
    -- Should plugins be lazy-loaded by default?
    lazy = false,
    -- Try installing the latest stable version for plugins that support semver
    version = '*',
  },
  spec = {
    { import = "plugins" },
  },
  install = {
    -- Install missing plugins on startup
    missing = true,
    -- Try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "solarized-osaka" },
  },
  checker = {
    enabled = false, -- automatically check for plugin updates
  },
})
