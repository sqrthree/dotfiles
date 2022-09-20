-- Map Leader + s to save the file.
vim.keymap.set('n', '<leader>s', '<cmd>write<cr>')

-- Select all text in current buffer
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
