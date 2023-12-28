return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-under-comparator",
    },
    config = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<C-n>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert
          }),
          ["<C-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "nvim_lsp_signature_help" }
        }, {
          { name = "buffer" },
        }, {
          { name = "path" }
        }),
        sorting = defaults.sorting,
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline("/", {
        sources = cmp.config.sources({
          { name = "nvim_lsp_document_symbol" }
        }, {
          { name = "buffer" }
        })
      })

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "nvim-cmp",
    },
    opts = {
      delete_check_events = "TextChanged",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
  {
    "dense-analysis/ale",
    event = "VeryLazy",
    keys = {
      { "<leader>dp", "<Plug>(ale_previous)", mode = "n", noremap = true, silent = true },
      { "<leader>dn", "<Plug>(ale_next)",     mode = "n", noremap = true, silent = true },
    },
    config = function()
      vim.api.nvim_set_var("ale_sign_error", "🚨")
      vim.api.nvim_set_var("ale_sign_warning", "⚠️")

      -- Run the linters only when files are saved.
      vim.api.nvim_set_var("ale_lint_on_text_changed", "never")
      vim.api.nvim_set_var("ale_lint_on_insert_leave", 0)

      -- Don not run linters on opening a file.
      vim.api.nvim_set_var("ale_lint_on_enter", 0)

      -- Set up the echoed message format.
      vim.api.nvim_set_var("ale_echo_msg_format", "[%linter%] %s [%severity%]")

      -- Disable ALE"s LSP functionality entirely.
      vim.api.nvim_set_var("ale_disable_lsp", 1)

      -- Make ALE display errors and warnings via the Neovim diagnostics API.
      vim.api.nvim_set_var("ale_use_neovim_diagnostics_api", 1)

      -- Only run linters named in ale_linters settings
      vim.api.nvim_set_var("ale_linters_explicit", 1)

      vim.api.nvim_set_var("ale_linters", {
        javascript      = { "cspell", "eslint", "tsserver" },
        javascriptreact = { "cspell", "eslint", "tsserver" },
        jsx             = { "cspell", "eslint", "tsserver" },
        typescript      = { "cspell", "eslint", "tsserver", "typecheck" },
        typescriptreact = { "cspell", "eslint", "tsserver", "typecheck" },
        tsx             = { "cspell", "eslint", "tsserver", "typecheck" },
        vue             = { "cspell", "volar" },
        json            = { "cspell", "eslint", },
        css             = { "stylelint" },
        go              = { "cspell", "gofmt", "gopls", "golint" },
        sh              = { "cspell", "shell", "language_server" },
        yaml            = { "cspell", "yamllint" },
      })
    end,
  },
  {
    "danymat/neogen",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    keys = {
      { "<leader>ng", ":lua require('neogen').generate()<CR>",                   mode = "n", noremap = true, silent = true },
      { "<leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>",  mode = "n", noremap = true, silent = true },
      { "<leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", mode = "n", noremap = true, silent = true },
      { "<leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>",  mode = "n", noremap = true, silent = true },
      { "<C-h>",      ":lua require('neogen').jump_prev<CR>",                    mode = "n", noremap = true, silent = true },
      { "<C-l>",      ":lua require('neogen').jump_next<CR>",                    mode = "n", noremap = true, silent = true },
    },
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    keys = {
      { "<leader>c",  "gcc", desc = "Toggle comment on current line", remap = true,  },
    },
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
