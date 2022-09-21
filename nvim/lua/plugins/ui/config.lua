local config = {}

function config.lualine()
  local initial = function(str)
    return str:sub(1,1)
  end

  require('lualine').setup({
    options = {
      theme = 'solarized_dark',
      fmt = string.lower,
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = initial,
        }
      },
      lualine_c = {
        {
          'filename',
          path = 1,
        }
      },
    }
  })
end

function config.tree()
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
