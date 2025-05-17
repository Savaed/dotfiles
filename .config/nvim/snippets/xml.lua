local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    { trig = "prop", desc = "Object property" },
    fmt(
      [[
        <property name="{}">{}</property>
        {}
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = "start", desc = "Starting boilerplate UI code" },
    fmt(
      [[
        <?xml version="1.0" encoding="UTF-8"?>
        <interface>
            <requires lib="gtk" version="4.0"/>
            <requires lib="Adw" version="1.0"/>
            <template class="{}" parent="{}">

                {}

            </template>
        </interface>
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "child", desc = "Child node" },
    fmt(
      [[
        <child type="{}">
            {}
        </child>
      ]],
      {
        i(1, "top"),
        i(0),
      }
    )
  ),

  s(
    { trig = "object", desc = "Object node" },
    fmt(
      [[
        <object class="{}" id="{}">
            {}
        </object>
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = "menu", desc = "Menu node" },
    fmt(
      [[
          <menu id="{}">
              <section>
                  <item>
                      <attribute name="label" translatable="{}">{}</attribute>
                      <attribute name="action">{}</attribute>
                  </item>
                  {}
              </section>
          </menu>
      ]],
      {
        i(1),
        i(2, "yes"),
        i(3),
        i(4),
        i(0),
      }
    )
  ),

  s(
    { trig = "style", desc = "CSS style" },
    fmt(
      [[
        <style>
            <class name="{}"/>
            {}
        </style>
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    { trig = "signal", desc = "Signal handler" },
    fmt(
      [[
        <signal name="{}" handler="{}" swapped="no"/>
        {}
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
}

-- <signal name="signal-name" handler="handler-name" [after="boolean"] [swapped="boolean"] [object="object-id"]/>
