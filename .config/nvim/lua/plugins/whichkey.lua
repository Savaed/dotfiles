return {
  {
    "folke/which-key.nvim",
    dependencies = {
      "mrjones2014/legendary.nvim",
      "echasnovski/mini.icons",
    },
    event = "VeryLazy",
    opts = {
      setup = {
        show_help = true,
        -- plugins = { spelling = { enabled = true } },
        replace = { ["<leader>"] = "SPC" },
        triggers = { "auto" },
        win = {
          border = "single", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
      },
    },
    config = function(_, _)
      local wk = require("which-key")
      wk.add({
        {
          mode = { "n", "v" },
          { "<leader>b", group = "Buffer" },
          { "<leader>c", group = "Code" },
          { "<leader>ca", desc = "Code actions" },
          { "<leader>d", group = "Debug" },
          { "<leader>f", group = "File" },
          { "<leader>g", group = "Git" },
          { "<leader>h", group = "Help" },
          { "<leader>m", group = "Harpoon marks", icon = "" },
          { "<leader>q", group = "Quit/Session" },
          { "<leader>r", group = "Refactor", icon = "" },
          { "<leader>rr", desc = "Rename" },
          { "<leader>s", group = "Splits", icon = "" },
          { "<leader>st", group = "Toggle orientation" },
          { "<leader>w", group = "Window" },
          { "<leader>x", group = "Quickfixes/Diagnostics" },
          { "<leader>z", group = "System" },
          { "<leader>l", group = "LaTex", icon = "" },
        },
      })
    end,
  },
}
