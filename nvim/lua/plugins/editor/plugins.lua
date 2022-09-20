local editor = {}
local config = require('plugins.editor.config')

-- Motions
editor['easymotion/vim-easymotion'] = {
  opt = true,
  event = 'BufReadPre',
  config = config.easymotion,
}

-- Prettification
editor['junegunn/vim-easy-align'] = {
  opt = true,
  event = 'BufReadPre',
  cmd = 'EasyAlign',
}
editor['prettier/vim-prettier'] = {
  opt = true,
  event = 'BufReadPre',
  config = config.prettier,
  run = 'yarn install --frozen-lockfile --production',
}

-- Highlights
editor['nvim-treesitter/nvim-treesitter'] = {
  opt = true,
  run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  event = 'BufReadPost',
  config = config.nvim_treesitter,
  requires = {
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
  }
}
editor['nvim-treesitter/nvim-treesitter-refactor'] = {
  opt = true,
  after = 'nvim-treesitter',
}
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
  opt = true,
  after = 'nvim-treesitter',
}

-- Linting
editor['dense-analysis/ale'] = {
  opt = true,
  event = 'BufReadPost',
  config = config.ale,
}

-- Documentation
editor['danymat/neogen'] = {
  config = config.neogen,
  keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
  requires = 'nvim-treesitter',
}

return editor
