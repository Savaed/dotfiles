return {
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "nightfly"
    -- end
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = true,
    priority = 1000,
    --config = function()
    --  vim.cmd.colorscheme 'onedark'
    --end,
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    opts = {
      mirage = true,
    },
    priority = 1000,
    -- config = function()
    --  vim.cmd.colorscheme 'ayu-mirage'
    --end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
      local colors = require("catppuccin.palettes").get_palette() -- fetch colors from g:catppuccin_flavour palette

      require("catppuccin").setup({
        custom_highlights = {
          Cursor = { fg = colors.peach, bg = colors.sky },
        },
      })
    end,
  },
}
