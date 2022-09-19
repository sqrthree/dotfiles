local config_path = require('constants.global').config_path
local data_dir = require('constants.global').data_dir

local plugins_dir = config_path .. '/lua/plugins'
local packer_compiled = data_dir .. '/lua/_packer_compiled.lua'
local packer_compiled_backup = data_dir .. '/lua/_packer_compiled_backup.lua'

local packer = nil

local Packer = {}

function Packer:ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command('packadd packer.nvim')
    return true
  end

  return false
end

function Packer:load_packer()
  if not packer then
    vim.api.nvim_command('packadd packer.nvim')
    packer = require('packer')

    packer.init {
      compile_path = packer_compiled,
      disable_commands = true,
      display = {
        open_fn = function()
          local result, win, buf = require('packer.util').float {
            border = {
              { '╭', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╮', 'FloatBorder' },
              { '│', 'FloatBorder' },
              { '╯', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╰', 'FloatBorder' },
              { '│', 'FloatBorder' },
            },
          }
          vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
          return result, win, buf
        end,
      },
    }
  end

  packer.reset()
end

function Packer:load_plugins()
  self.repos = {}

  local get_plugins_list = function()
    local list = {}
    local tmp = vim.split(vim.fn.globpath(plugins_dir, '*/plugins.lua'), '\n')
    for _, f in ipairs(tmp) do
      list[#list + 1] = f:sub(#plugins_dir - 6, -1)
    end
    return list
  end

  local plugins_file = get_plugins_list()
  for _, m in ipairs(plugins_file) do
    local repos = require(m:sub(0, #m - 4))
    for repo, conf in pairs(repos) do
      self.repos[#self.repos + 1] = vim.tbl_extend('force', { repo }, conf)
    end
  end
end

function Packer:setup()
  self:load_packer()
  self:load_plugins()

  local use = packer.use

  use({ 'wbthomason/packer.nvim', opt = true })
  for _, repo in ipairs(self.repos) do
    use(repo)
  end
end

function Packer:ensure()
  local packer_bootstrap = self:ensure_packer()

  self:setup()

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    packer.sync()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    if not packer then
      Packer:setup()
    end

    return packer[key]
  end,
})

function plugins:ensure_plugins()
  Packer:ensure()
end

function plugins.backup_compile()
	if vim.fn.filereadable(packer_compiled) == 1 then
		os.rename(packer_compiled, packer_compiled_backup)
	end

	plugins.compile()

	vim.notify('Packer compiled successfully!', vim.log.levels.INFO, { title = 'Success!' })
end

function plugins.load_compile()
  if vim.fn.filereadable(packer_compiled) == 1 then
    require('_packer_compiled')
  else
    assert('Missing packer compile file. Please run PackerCompile Or PackerInstall to fix')
  end

  -- Commands
  local create_cmd = vim.api.nvim_create_user_command
  local autocmd = vim.api.nvim_create_autocmd

  create_cmd('PackerInstall', function()
    vim.api.nvim_command('packadd packer.nvim')
    require('plugins').install()
  end, {})
  create_cmd('PackerUpdate', function()
    vim.api.nvim_command('packadd packer.nvim')
    require('plugins').update()
  end, {})
  create_cmd('PackerSync', function()
    vim.api.nvim_command('packadd packer.nvim')
    require('plugins').sync()
  end, {})
  create_cmd('PackerClean', function()
    vim.api.nvim_command('packadd packer.nvim')
    require('plugins').clean()
  end, {})
  create_cmd('PackerCompile', function()
    vim.api.nvim_command('packadd packer.nvim')
    require('plugins').backup_compile()
  end, {})
end

return plugins
