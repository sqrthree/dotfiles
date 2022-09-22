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

-- Plugin Comment
local comment = function()
  local options = { silent = true, noremap = true }

  map('n', '<leader>c', '<Plug>(comment_toggle_linewise_current)', options)
  map('n', '<leader>bc', '<Plug>(comment_toggle_blockwise_current)', options)
  map('x', '<leader>c', '<Plug>(comment_toggle_linewise_visual)', options)
  map('x', '<leader>bc', '<Plug>(comment_toggle_blockwise_visual)', options)
end

comment()
