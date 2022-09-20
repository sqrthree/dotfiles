local editor = {}
local config = require('plugins.editor.config')

-- Prettification
editor['junegunn/vim-easy-align'] = {
  opt = true,
  cmd = 'EasyAlign',
}
editor['prettier/vim-prettier'] = {
  opt = true,
  run = 'yarn install --frozen-lockfile --production',
}

-- Highlights
editor['nvim-treesitter/nvim-treesitter'] = {
	opt = true,
  run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	event = 'BufReadPost',
	config = config.nvim_treesitter,
}
editor['nvim-treesitter/nvim-treesitter-refactor'] = {
  opt = true,
  after = 'nvim-treesitter',
}
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
  opt = true,
  after = 'nvim-treesitter',
}

-- Documentation
editor['danymat/neogen'] = {
  config = config.neogen,
  keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
  requires = 'nvim-treesitter',
}

return editor
