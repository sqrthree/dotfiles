-- Configure things only for Neovide.
-- This file will be loaded only when running in Neovide.

local g = vim.g
local keymap = vim.keymap

-- Don't remember previous window size.
g.neovide_remember_window_size = false

-- enable use of the logo (cmd) key
g.neovide_input_use_logo = 1

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end

-- Setup styles
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
g.neovide_transparency = 0.0
g.transparency = 0.8
g.neovide_background_color = "#002b36" .. alpha()

-- Allow clipboard copy paste in neovide.
keymap.set("n", "<D-s>", ":w<CR>")      -- Save
keymap.set("v", "<D-c>", '"+y')         -- Copy
keymap.set("n", "<D-v>", '"+P')         -- Paste normal mode
keymap.set("v", "<D-v>", '"+P')         -- Paste visual mode
keymap.set("c", "<D-v>", "<C-R>+")      -- Paste command mode
keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
