local config = {}

function config.nvim_treesitter()
  require('nvim-treesitter.install').prefer_git = true

  local parsers = require('nvim-treesitter.parsers').get_parser_configs()
  for _, p in pairs(parsers) do
    p.install_info.url = p.install_info.url:gsub('https://github.com/', 'git@github.com:')
  end

  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
  vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      vim.opt.foldmethod     = 'expr'
      vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    end
  })

  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'javascript',
      'typescript',
      'tsx',
      'json',
      'yaml',
      'go',
      'rust',
    },
    highlight = { enable = true, },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]["] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]]"] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = false,
      },
      highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = 'grr',
        },
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = 'gnd',
          list_definitions = 'gnD',
          list_definitions_toc = 'gO',
          goto_next_usage = '<a-*>',
          goto_previous_usage = '<a-#>',
        },
      },
    },
  })
end

function config.neogen()
  require('neogen').setup {}
end

return config