local config = {}

function config.nvim_lsp()
  require('plugins.completion.lsp.language-servers')
  require('plugins.completion.lsp.nvim-cmp-config')
end

function config.luasnip()
  local vscode = require('luasnip.loaders.from_vscode')
  
  vscode.lazy_load()
end

return config
