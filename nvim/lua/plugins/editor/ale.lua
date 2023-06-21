local config = function()
  vim.api.nvim_set_var("ale_sign_error", "🚨")
  vim.api.nvim_set_var("ale_sign_warning", "⚠️")

  -- Run the linters only when files are saved.
  vim.api.nvim_set_var("ale_lint_on_text_changed", "never")
  vim.api.nvim_set_var("ale_lint_on_insert_leave", 0)

  -- Don not run linters on opening a file.
  vim.api.nvim_set_var("ale_lint_on_enter", 0)

  -- Set up the echoed message format.
  vim.api.nvim_set_var("ale_echo_msg_format", "[%linter%] %s [%severity%]")

  -- Disable ALE"s LSP functionality entirely.
  vim.api.nvim_set_var("ale_disable_lsp", 1)

  -- Make ALE display errors and warnings via the Neovim diagnostics API.
  vim.api.nvim_set_var("ale_use_neovim_diagnostics_api", 1)

  -- Only run linters named in ale_linters settings
  vim.api.nvim_set_var("ale_linters_explicit", 1)

  vim.api.nvim_set_var("ale_linters", {
    javascript      = { "cspell", "eslint", "tsserver" },
    javascriptreact = { "cspell", "eslint", "tsserver" },
    jsx             = { "cspell", "eslint", "tsserver" },
    typescript      = { "cspell", "eslint", "tsserver", "typecheck" },
    typescriptreact = { "cspell", "eslint", "tsserver", "typecheck" },
    tsx             = { "cspell", "eslint", "tsserver", "typecheck" },
    vue             = { "cspell", "volar" },
    json            = { "cspell", "eslint", },
    css             = { "stylelint" },
    go              = { "cspell", "gofmt", "gopls", "golint" },
    sh              = { "cspell", "shell", "language_server" },
    yaml            = { "cspell", "yamllint" },
  })
end

return {
  "dense-analysis/ale",
  event = "BufReadPost",
  config = config,
  keys = {
    { "<C-j>", "<Plug>(ale_next_wrap)", mode = "n", noremap = true, silent = true },
  },
}
