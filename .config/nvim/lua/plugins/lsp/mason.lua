return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- "coreclr",
        -- "tsserver",
        "html",
        "cssls",
        --   "tailwindcss",
        --   "svelte",
        "lua_ls",
        "texlab",
        --   "graphql",
        --   "emmet_ls",
        --   "prismals",
        -- "eslint_d",
        -- "jsonlint",
        "ts_ls",
        "ruff",
        "bashls",
        "omnisharp",
        "pyright",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
        "jsonlint",
        "stylelint",
        "shellcheck",
      },
    })
  end,
}
