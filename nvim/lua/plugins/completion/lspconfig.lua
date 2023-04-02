return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWinEnter", "BufNewFile" },
  config = function()
    require("plugins.completion.config.language-servers")
  end
}
