local editor = {}
local config = require('plugins.editor.config')

-- Prettification
editor['junegunn/vim-easy-align'] = {
  opt = true,
  cmd = 'EasyAlign',
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
editor['nvim-treesitter/nvim-treesitter-textsubjects'] = {
  opt = true,
  after = 'nvim-treesitter',
}

return editor
