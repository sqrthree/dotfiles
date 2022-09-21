local global = {}

local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  local home = os.getenv('HOME')

	self.is_mac = os_name == 'Darwin'
	self.is_linux = os_name == 'Linux'
	self.config_path = vim.fn.stdpath('config')
	self.cache_dir = home .. '/.cache/nvim/'
	self.home = home
	self.data_dir = string.format('%s/site/', vim.fn.stdpath('data'))
end

global:load_variables()

return global
