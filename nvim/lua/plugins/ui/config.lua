local config = {}

function config.lualine()
  require('lualine').setup {
    options = { theme = 'solarized_dark' }
  }
end

function config.tree()
  vim.api.nvim_set_var('loaded', 1)
  vim.api.nvim_set_var('loaded_netrwPlugin', 1)

  require('nvim-tree').setup({
    sort_by = 'case_sensitive',
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = 'u', action = 'dir_up' },
        },
      },
    },
    renderer = {
      group_empty = true,
      highlight_opened_files = 'icon',
    },
    filters = {
      dotfiles = true,
    },
    update_focused_file = {
      enable = true,
    },
  })
end

return config
