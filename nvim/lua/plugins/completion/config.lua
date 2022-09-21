local config = {}

function config.lsp()
  require('plugins.completion.lsp.language-servers')
end

function config.cmp()
  require('plugins.completion.lsp.nvim-cmp-config')
end

function config.luasnip()
  local vscode = require('luasnip.loaders.from_vscode')

  vscode.lazy_load()
end

return config
