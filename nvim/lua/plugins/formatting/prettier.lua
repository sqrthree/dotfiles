return {
  "prettier/vim-prettier",
  build = "yarn install --frozen-lockfile --production",
  keys = {
    { "<leader>p", "<cmd>PrettierAsync<cr>", mode = "n", silent = true, noremap = true },
  },
  config = function()
    -- Setup autoformatting files based on whether a config file can be found in
    -- the current directory or any parent directory.
    vim.api.nvim_set_var("prettier#autoformat_require_pragma", 0)
    vim.api.nvim_set_var("prettier#autoformat_config_present", 1)

    -- Force the command `:Prettier` to async.
    vim.api.nvim_set_var("prettier#exec_cmd_async", 1)
  end,
}
