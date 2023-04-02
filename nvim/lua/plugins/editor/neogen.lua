return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = {
    { "<leader>n",  ":lua require('neogen').generate()<CR>",                   mode = "n", noremap = true, silent = true },
    { "<leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>",  mode = "n", noremap = true, silent = true },
    { "<leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", mode = "n", noremap = true, silent = true },
    { "<leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>",  mode = "n", noremap = true, silent = true },
    { "<C-h>",      ":lua require('neogen').jump_prev<CR>",                    mode = "n", noremap = true, silent = true },
    { "<C-l>",      ":lua require('neogen').jump_next<CR>",                    mode = "n", noremap = true, silent = true },
  },
  config = function()
    require("neogen").setup({
      snippet_engine = "luasnip",
    })
  end,
}
