return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
  },
  keys = {
    { "<C-p>",      "<cmd>Telescope find_files<cr>", mode = "n", silent = true, noremap = true },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", mode = "n", silent = true, noremap = true },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  mode = "n", silent = true, noremap = true },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    mode = "n", silent = true, noremap = true },
    { "<leader>fn", "<cmd>Telescope help_tags<cr>",  mode = "n", silent = true, noremap = true },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-o>"] = actions.select_default,                                -- open the selection in the current buffer
            ["<C-s>"] = actions.select_horizontal,                             -- go to file selection as a split
            ["<C-x>"] = actions.select_horizontal,                             -- go to file selection as a split
            ["<C-v>"] = actions.select_vertical,                               -- open the selection in a new vertical split
            ["<C-t>"] = actions.select_tab,                                    -- open the selection in a new tab
            ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
            ["<C-j>"] = actions.move_selection_next,                           -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
          },
          n = {
            ["o"] = actions.select_default,                                -- open the selection in the current buffer
            ["s"] = actions.select_horizontal,                             -- go to file selection as a split
            ["x"] = actions.select_horizontal,                             -- go to file selection as a split
            ["v"] = actions.select_vertical,                               -- open the selection in a new vertical split
            ["t"] = actions.select_tab,                                    -- open the selection in a new tab
            ["k"] = actions.move_selection_previous,                       -- move to prev result
            ["j"] = actions.move_selection_next,                           -- move to next result
            ["q"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
          },
        }
      },
      extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<C-o>"] = actions.select_default,    -- open the selection in the current buffer
              ["<C-s>"] = actions.select_horizontal, -- go to file selection as a split
              ["<C-x>"] = actions.select_horizontal, -- go to file selection as a split
              ["<C-v>"] = actions.select_vertical,   -- open the selection in a new vertical split
              ["<C-t>"] = actions.select_tab,        -- open the selection in a new tab
              ["<C-c>"] = fb_actions.create,         -- Create file/folder at current path (trailing path separator creates folder)
              ["<Tab>"] = fb_actions.change_cwd,     -- change working directory of nvim to the selected file/folder
            },
            n = {
              ["o"] = actions.select_default,    -- open the selection in the current buffer
              ["s"] = actions.select_horizontal, -- go to file selection as a split
              ["x"] = actions.select_horizontal, -- go to file selection as a split
              ["v"] = actions.select_vertical,   -- open the selection in a new vertical split
              ["t"] = actions.select_tab,        -- open the selection in a new tab
              ["c"] = fb_actions.create,         -- Create file/folder at current path (trailing path separator creates folder)
              ["<Tab>"] = fb_actions.change_cwd, -- change working directory of nvim to the selected file/folder
            },
          }
        }
      }
    })

    telescope.load_extension "file_browser"
  end,
}
