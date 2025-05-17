return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      -- local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local icons = require("config.icons")

      local keymap = vim.keymap -- for conciseness

      local desc = function(desc, buffer)
        return { noremap = true, silent = true, desc = desc, buffer = buffer }
      end

      local on_attach = function(_, bufnr)
        -- set keybinds
        -- keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", desc("Goto references", bufnr))
        -- keymap.set("n", "gD", vim.lsp.buf.declaration, desc("Goto declaration", bufnr))
        -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", desc("Goto definitions", bufnr))
        -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", desc("Goto implementations", bufnr))
        -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", desc("Goto type definitions", bufnr))
        -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, desc("Code actions", bufnr))
        -- keymap.set("n", "<leader>rr", vim.lsp.buf.rename, desc("Rename symbol under cursor", bufnr))
        -- -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", desc("Buffer diagnostics", bufnr)) -- show  diagnostics for file
        -- -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, desc("Line diagnostics", bufnr)) -- show diagnostics for line
        -- keymap.set("n", "[d", vim.diagnostic.goto_prev, desc("Previous diagnostics", bufnr))
        -- keymap.set("n", "]d", vim.diagnostic.goto_next, desc("Next diagnostics", bufnr))
        -- keymap.set("n", "K", vim.lsp.buf.hover, desc("Documentation", bufnr))
        -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", desc("Restart LSP", bufnr))
      end

      -- used to enable autocompletion (assign to every lsp server config)
      -- local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      local d_icons = icons.diagnostics
      local signs = {
        Error = d_icons.BoldError,
        Warn = d_icons.BoldWarning,
        Hint = d_icons.BoldHint,
        Info = d_icons.BoldInformation,
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- configure python server
      lspconfig["pyright"].setup({
        -- capabilities = capabilities,
        on_attach = on_attach,
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "off",
          },
        },
      })

      lspconfig["omnisharp"].setup({
        cmd = {
          vim.fn.exepath("omnisharp"),
          "--languageserver",
          "--hostPID",
          vim.fn.getpid(),
        },
        -- capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["bashls"].setup({
        -- capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["ts_ls"].setup({
        -- capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["texlab"].setup({
        -- capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure lua server (with special settings)
      lspconfig["lua_ls"].setup({
        -- capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
