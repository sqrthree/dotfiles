local map = vim.api.nvim_set_keymap

-- Plugin EasyAlign
local easy_align = function()
  local options = { silent = true, noremap = false }

  map('x', 'ga', '<Plug>(EasyAlign)', options)
  map('n', 'ga', '<Plug>(EasyAlign)', options)
end

easy_align()
