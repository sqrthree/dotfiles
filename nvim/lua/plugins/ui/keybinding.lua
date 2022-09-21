local map = vim.api.nvim_set_keymap

-- Plugin nvim-tree
local tree = function()
  local options = { silent = true, noremap = true }

  map('n', '<C-b>', '<cmd>NvimTreeToggle<cr>', options)
  map('i', '<C-b>', '<cmd>NvimTreeToggle<cr>', options)
  map('n', '<D-b>', '<cmd>NvimTreeToggle<cr>', options)
  map('i', '<D-b>', '<cmd>NvimTreeToggle<cr>', options)
  map('n', '<leader>b', '<cmd>NvimTreeFocus<cr>', options)
end

tree()
