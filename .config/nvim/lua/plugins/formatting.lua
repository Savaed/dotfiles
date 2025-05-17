return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        --   javascriptreact = { "prettierd" },
        --   typescriptreact = { "prettierd" },
        --   svelte = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        --   graphql = { "prettierd" },
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        csharp = { "csharpier" },
      },
      -- format_after_save = true,
      format_on_save = {
        lsp_fallback = true,
        -- async = true,
        timeout_ms = 1000,
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 1000,
      })
    end, { desc = "Code format" })
  end,
}
