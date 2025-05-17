return {
  "L3MON4D3/LuaSnip",
  -- { "n", "<leader><leader>n", "<cmd>source ~/.config/nvim/lua/plugins/snippets.lua<cr>" },
  opts = {
    enable_autosnippets = true,
  },
  config = function()
    local ls = require("luasnip")

    vim.keymap.set({ "i", "n" }, "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "n" }, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
  end,
}
