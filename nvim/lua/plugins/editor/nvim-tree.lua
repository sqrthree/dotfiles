local config = function()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      side = "right",
      adaptive_size = true,
      mappings = {
        list = {
          { key = "s", action = "split" },
          { key = "v", action = "vsplit" },
        },
      },
    },
    renderer = {
      group_empty = true,
      highlight_opened_files = "icon",
    },
    filters = {
      dotfiles = true,
    },
    update_focused_file = {
      enable = true,
    },
  })
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeCollapse",
  },
  keys = {
    { "<C-b>",     "<cmd>NvimTreeToggle<cr>", mode = "n", silent = true, noremap = true },
    { "<C-b>",     "<cmd>NvimTreeToggle<cr>", mode = "i", silent = true, noremap = true },
    { "<D-b>",     "<cmd>NvimTreeToggle<cr>", mode = "n", silent = true, noremap = true },
    { "<D-b>",     "<cmd>NvimTreeToggle<cr>", mode = "i", silent = true, noremap = true },
    { "<leader>e", "<cmd>NvimTreeFocus<cr>",  mode = "n", silent = true, noremap = true },
  },
  config = config,
}
