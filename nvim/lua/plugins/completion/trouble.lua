return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>",                       mode = "n", silent = true, noremap = true },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", mode = "n", silent = true, noremap = true },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  mode = "n", silent = true, noremap = true },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               mode = "n", silent = true, noremap = true },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              mode = "n", silent = true, noremap = true },
    { "<leader>gR", "<cmd>TroubleToggle lsp_references<cr>",        mode = "n", silent = true, noremap = true },
  },
}
