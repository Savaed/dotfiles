local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    { trig = "///", desc = "C# docs comment" },
    fmt(
      [[
    /// <summary>
    /// {}.
    /// </summary>
    /// <param name="{}">{}.</param>
    /// <returns>{}.</returns>
     ]],
      { i(1), i(2), i(3), i(4) }
    )
  ),
}
