return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
  },
  keys = {
    {
      "<leader>fe",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
      mode = "n",
      silent = true,
      noremap = true
    },
  }
}
