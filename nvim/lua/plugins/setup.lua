local data_dir = require("constants.global").data_dir
local plugin_dir = data_dir .. "/lazy"

local Setup = {}

local lazypath = plugin_dir .. "/lazy.nvim"

function Setup:ensure_lazy()
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
end

function Setup:ensure_plugins()
  require("lazy").setup({
    root = plugin_dir,
    spec = {
      { import = "plugins.ui" },
      { import = "plugins.tools" },
      { import = "plugins.completion" },
      { import = "plugins.editor" },
      { import = "plugins.formatting" },
    }
  })
end

return Setup
