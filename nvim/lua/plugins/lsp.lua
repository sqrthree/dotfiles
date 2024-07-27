local on_attach = function(client, bufnr)
  local navic = require("nvim-navic")
  local navbuddy = require("nvim-navbuddy")

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        config = function()
          local navbuddy = require("nvim-navbuddy")

          navbuddy.setup({})

          -- Mappings.
          local opts = { noremap = true, silent = true }

          vim.keymap.set("n", "<leader>nb", navbuddy.open, opts)
        end
      }
    },
    config = function()
      local lspconfig = require("lspconfig")
      local schemas = require('schemastore').json.schemas()

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      })

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            schemas = schemas,
            format = { enable = true },
            validate = { enable = true },
          },
        },
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.volar.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Mappings.
      local opts = { noremap = true, silent = true }

      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Enable the inlay hints by default.
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {
              bufnr = buffer
            })
          end

          -- Enable completion triggered by <c-x><c-o>
          vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = buffer }

          vim.keymap.set("n", "glD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gld", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "glr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gli", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
    },
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      -- ALl available LSP servers can be found at the following url:
      -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
      ensure_installed = {
        "volar",
        "jsonls",
        "bashls",
      },
      automatic_installation = true,
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- Add additional capabilities supported by nvim-cmp
      local mason_registry = require("mason-registry")
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()
          .. "/node_modules/@vue/language-server"
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("typescript-tools").setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          -- "vue",
        },
        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = "insert_leave",
          -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
          -- "remove_unused_imports"|"organize_imports") -- or string "all"
          -- to include all supported code actions
          -- specify commands exposed as code_actions
          expose_as_code_action = "all",
          -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
          -- not exists then standard path resolution strategy is applied
          tsserver_path = nil,
          -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
          -- (see 💅 `styled-components` support section)
          tsserver_plugins = {
            -- {
            --   name = '@vue/typescript-plugin',
            --   location = vue_language_server_path,
            --   languages = { 'vue' },
            -- },
          },
          -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
          -- memory limit in megabytes or "auto"(basically no limit)
          tsserver_max_memory = "auto",
          -- All available options can be found in typescript repository.
          -- Example: https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
          tsserver_format_options = {},
          -- Example: https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all', -- "none" | "literals" | "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = false,
          },
          -- locale of all tsserver messages, supported locales you can find here:
          -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
          tsserver_locale = "en",
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = "off",
          -- by default code lenses are displayed on all referencable values and for some of you it can
          -- be too much this option reduce count of them by removing member references from lenses
          disable_member_code_lens = true,
          -- JSXCloseTag
          -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
          -- that maybe have a conflict if enable this feature. )
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          }
        },
      })
    end
  }
}
