local map = vim.api.nvim_set_keymap

-- Plugin vim-easy-align
local easy_align = function()
  local options = { silent = true, noremap = false }

  map('x', 'ga', '<Plug>(EasyAlign)', options)
  map('n', 'ga', '<Plug>(EasyAlign)', options)
end

easy_align()

-- Plugin vim-easymotion
local easymotion = function()
  local options = { silent = true, noremap = true }

  map('n', 's', '<Plug>(easymotion-s2)', options)
  map('n', 't', '<Plug>(easymotion-t2)', options)
end

easymotion()

-- Plugin telescope
local telescope = function()
  local options = { silent = true, noremap = true }

  map('n', '<C-p>', '<cmd>Telescope find_files<cr>', options)
  map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
  map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)
  map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', options)
  map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)
end

telescope()
