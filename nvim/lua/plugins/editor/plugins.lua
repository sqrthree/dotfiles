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
  event = { 'BufWinEnter', 'BufNewFile' },
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

-- Indentation guides
editor['lukas-reineke/indent-blankline.nvim'] = {
  opt = true,
  event = { 'BufWinEnter', 'BufNewFile' },
  config = config.blankline,
  after = 'nvim-treesitter',
}

-- Documentation
editor['danymat/neogen'] = {
  config = config.neogen,
  keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
  requires = 'nvim-treesitter',
}

-- Comment
editor['numToStr/Comment.nvim'] = {
  opt = true,
  event = { 'BufReadPost', 'BufNewFile' },
  config = config.comment,
}

-- Autopairs
editor['windwp/nvim-autopairs'] = {
  opt = true,
  event = 'InsertEnter',
  config = config.autopairs,
}

-- Search
editor['nvim-lua/plenary.nvim'] = {
  opt = false,
}
editor['nvim-telescope/telescope.nvim'] = {
  opt = true,
  module = 'telescope',
  cmd = 'Telescope',
  config = config.telescope,
  requires = {
    { 'nvim-lua/plenary.nvim', opt = false },
    { 'nvim-lua/popup.nvim', opt = true },
  },
}

-- File Explorer
editor['nvim-tree/nvim-tree.lua'] = {
  opt = true,
  config = config.tree,
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeCollapse', },
}

return editor
