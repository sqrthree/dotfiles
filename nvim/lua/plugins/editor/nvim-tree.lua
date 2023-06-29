local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings.
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings.
  vim.keymap.set('n', 't', api.node.open.tab,                     opts('Open: New Tab'))
  vim.keymap.set('n', 'v', api.node.open.vertical,                opts('Open: Vertical Split'))
  vim.keymap.set('n', 's', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  vim.keymap.set('n', '?', api.tree.toggle_help,                  opts('Help'))

end

local config = function()
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      side = "right",
      adaptive_size = true,
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
    on_attach = on_attach,
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
