local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local foo = function()
  local x = vim.api.nvim_buf_get_name(0)
  local _, two = x:match("([^.]+)/([^.]+)")
  return two
end

return {
  s("center", fmt('<p style="text-align: center; font-style: italic;">{}</p>', { i(0) })),
  s("hrhidden", t('<hr style="margin: -4px 0; border: none;"/>')), -- negative margin top and bottom to remove spacing
  s(
    "prop",
    fmt(
      [[
        ---
        id: {}
        aliases: [] 
        tags:
          - {} 
        date: {}
        topics:
          - {}
        ---

        # {}

        {}

        # Bibliografia

      ]],
      {
        f(foo),
        i(1),
        f(function()
          return os.date("%d.%m.%Y %H:%M")
        end),
        i(2),
        f(foo),
        i(0),
      }
    )
  ),
}
