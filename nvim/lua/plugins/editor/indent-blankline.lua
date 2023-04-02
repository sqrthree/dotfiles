return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  dependencies = { "nvim-treesitter" },
  config = function()
    vim.api.nvim_set_var("indent_blankline_char_list", { "¦", "┆", "┊" })
    vim.api.nvim_set_var("indent_blankline_use_treesitter", true)
    vim.api.nvim_set_var("indentLine_faster", 1)
    vim.api.nvim_set_var("indentLine_fileTypeExclude", { "tex", "markdown", "txt", "startify" })
    vim.api.nvim_set_var("indent_blankline_show_first_indent_level", false)
    vim.api.nvim_set_var("indent_blankline_show_trailing_blankline_indent", false)

    require("indent_blankline").setup({
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    })
  end,
}
