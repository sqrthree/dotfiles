local map = vim.api.nvim_set_keymap

-- Plugin EasyAlign
local easy_align = function()
  vim.api.nvim_command('packadd vim-easy-align')

  local options = { silent = true, noremap = false }

  map('x', 'ga', '<Plug>(EasyAlign)', options)
  map('n', 'ga', '<Plug>(EasyAlign)', options)
end

easy_align()
