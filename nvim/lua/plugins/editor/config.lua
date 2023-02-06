local config = {}

function config.prettier()
  -- Setup autoformatting files based on whether a config file can be found in
  -- the current directory or any parent directory.
  vim.api.nvim_set_var('prettier#autoformat_require_pragma', 0)
  vim.api.nvim_set_var('prettier#autoformat_config_present', 1)

  -- Running before saving async.
  -- vim.api.nvim_create_autocmd(
  --   { 'BufWritePre' },
  --   {
  --     pattern = { '*.js', '*.jsx', '*.mjs', '*.ts', '*.tsx', '*.css', '*.less', '*.scss', '*.json', '*.graphql', '*.md', '*.vue', '*.yaml', '*.html' },
  --     command = 'PrettierAsync'
  --   }
  -- )
end

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
      'lua',
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
      -- To disable slow treesitter highlight for large files.
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']['] = '@function.outer',
          [']m'] = '@class.outer',
        },
        goto_next_end = {
          [']]'] = '@function.outer',
          [']M'] = '@class.outer',
        },
        goto_previous_start = {
          ['[['] = '@function.outer',
          ['[m'] = '@class.outer',
        },
        goto_previous_end = {
          ['[]'] = '@function.outer',
          ['[M'] = '@class.outer',
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
  require('neogen').setup()
end

function config.ale()
  vim.api.nvim_set_var('ale_sign_error', '🚨')
  vim.api.nvim_set_var('ale_sign_warning', '⚠️')

  -- Run the linters only when files are saved.
  vim.api.nvim_set_var('ale_lint_on_text_changed', 'never')
  vim.api.nvim_set_var('ale_lint_on_insert_leave', 0)

  -- Don not run linters on opening a file.
  vim.api.nvim_set_var('ale_lint_on_enter', 0)

  -- Only run linters named in ale_linters settings
  vim.api.nvim_set_var('ale_linters_explicit', 1)

  vim.api.nvim_set_var('ale_linters', {
    javascript = { 'cspell', 'eslint', 'tsserver' },
    jsx        = { 'cspell', 'eslint', 'tsserver' },
    typescript = { 'cspell', 'eslint', 'tsserver', 'typecheck'},
    tsx        = { 'cspell', 'eslint', 'tsserver', 'typecheck'},
  })
end

function config.easymotion()
  vim.api.nvim_set_var('EasyMotion_smartcase', 1)
end

function config.blankline()
  vim.api.nvim_set_var('indent_blankline_char_list', { '¦', '┆', '┊' })
  vim.api.nvim_set_var('indent_blankline_use_treesitter', true)
  vim.api.nvim_set_var('indentLine_faster', 1)
  vim.api.nvim_set_var('indentLine_fileTypeExclude', { 'tex', 'markdown', 'txt', 'startify' })
  vim.api.nvim_set_var('indent_blankline_show_first_indent_level', false)
  vim.api.nvim_set_var('indent_blankline_show_trailing_blankline_indent', false)

  require('indent_blankline').setup({
    space_char_blankline = ' ',
    show_current_context = true,
    show_current_context_start = true,
  })
end

function config.comment()
  require('Comment').setup()
end

function config.autopairs()
  require("nvim-autopairs").setup()
end

function config.telescope()
  local actions = require('telescope.actions')

  require('telescope').setup({
    defaults = {
      mappings = {
        i = {
          ['<C-o>'] = actions.select_vertical,
          ['<C-S-o>'] = actions.select_tab,
        }
      }
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
          { key = 's', action = 'split' },
          { key = 'S', action = 'vsplit' },
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
