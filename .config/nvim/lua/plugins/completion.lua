return {
  "saghen/blink.cmp",
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  version = "*",
  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "hide" },
      ["<Tab>"] = { "select_and_accept" },

      ["Up"] = { "select_prev" },
      ["Down"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
      ["<C-j>"] = { "select_next" },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },

      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
      ["K"] = { "show_documentation", "hide_documentation" },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      min_keyword_length = function(ctx)
        -- only applies when typing a command, doesn't apply to arguments
        if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
          return 3
        end
        return 0
      end,
      providers = {
        buffer = {
          min_keyword_length = 3,
        },
      },
    },
    signature = { enabled = true },
    completion = {
      ghost_text = { enabled = false },
      menu = {
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              ellipsis = false,
              -- text = function(ctx)
              --   local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              --   return kind_icon
              -- end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          -- columns = { { "kind_icon" }, { "label", gap = 1 } },
          -- components = {
          --   label = {
          --     text = function(ctx)
          --       return require("colorful-menu").blink_components_text(ctx)
          --     end,
          --     highlight = function(ctx)
          --       return require("colorful-menu").blink_components_highlight(ctx)
          --     end,
          --   },
          -- },
        },
      },
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "",

        Field = "",
        Variable = "",
        Property = "",

        Class = "",
        Interface = "",
        Struct = "",
        Module = "󰅩",
        Unit = "󱖦",
        Value = "",
        Enum = "",
        EnumMember = "",

        Keyword = "",
        Constant = "󰏿",

        Snippet = "󰩫",
        Color = "󰸌",
        File = "",
        Reference = "",
        Folder = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      },
    },
  },
  opts_extend = { "sources.default" },
}
