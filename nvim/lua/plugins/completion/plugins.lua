local completion = {}
local config = require('plugins.completion.config')

-- Collection of configurations for built-in LSP client.
completion['neovim/nvim-lspconfig'] = {
  -- event = 'BufReadPre',
	config = config.nvim_lsp,
}

-- Snippets.
completion['L3MON4D3/LuaSnip'] = {
  -- event = 'InsertEnter',
	config = config.luasnip,
  requires = 'rafamadriz/friendly-snippets',
}

-- Autocompletion.
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
completion['hrsh7th/nvim-cmp'] = {
  -- after = 'LuaSnip',
  -- event = 'InsertEnter',
  requires = {
    { 'lukas-reineke/cmp-under-comparator' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer', },
    { 'hrsh7th/cmp-path', },
    { 'hrsh7th/cmp-cmdline', },
    { 'saadparwaiz1/cmp_luasnip', },
  }
}

return completion

