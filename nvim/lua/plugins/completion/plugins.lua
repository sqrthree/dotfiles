local completion = {}
local config = require('plugins.completion.config')

-- Collection of configurations for built-in LSP client.
completion['neovim/nvim-lspconfig'] = {
  opt = true,
  event = { 'BufReadPost', 'BufWinEnter', 'BufNewFile' },
  config = config.lsp,
}

-- Autocompletion.
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
completion['hrsh7th/nvim-cmp'] = {
  opt = true,
  event = 'InsertEnter',
  config = config.cmp,
  requires = {
    { 'lukas-reineke/cmp-under-comparator' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer', },
    { 'hrsh7th/cmp-path', },
    { 'hrsh7th/cmp-cmdline', },
    { 'saadparwaiz1/cmp_luasnip', },
  }
}
completion['hrsh7th/cmp-nvim-lsp'] = {
  opt = true,
  after = 'nvim-cmp',
}
completion['hrsh7th/cmp-buffer'] = {
  opt = true,
  after = 'cmp-nvim-lsp'
}
completion['hrsh7th/cmp-path'] = {
  opt = true,
  after = 'cmp-buffer',
}
completion['hrsh7th/cmp-cmdline'] = {
  opt = true,
  after = 'cmp-path'
}
completion['saadparwaiz1/cmp_luasnip'] = {
  opt = true,
  after = 'cmp-cmdline',
}
completion['hrsh7th/cmp-nvim-lsp-document-symbol'] = {
  opt = true,
  after = 'cmp_luasnip',
}
completion['hrsh7th/cmp-nvim-lsp-signature-help'] = {
  opt = true,
  after = 'cmp-nvim-lsp-document-symbol',
}

-- Snippets.
completion['rafamadriz/friendly-snippets'] = {
  opt = true,
  module = { "cmp", "cmp_nvim_lsp" },
  event = "InsertEnter",
}
completion['L3MON4D3/LuaSnip'] = {
  opt = true,
  event = 'InsertEnter',
  after = 'nvim-cmp',
  config = config.luasnip,
  requires = 'rafamadriz/friendly-snippets',
}

return completion
