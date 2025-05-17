local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "fig",
    fmt(
      [[
    \begin{{figure}}[h]
        \includegraphics[width=\textwidth]{{{}}}
        \caption{{{}}}
        \label{{{}}}
    \end{{figure}}

    {}
  ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    "docexample",
    fmt(
      [[
    \documentclass[a4paper, 12pt]{{{}}}

    \usepackage[T1]{{fontenc}}  % Wybór kodowania czcionek.
    \usepackage{{microtype}}  % Ulepszone ustawienia typografii.
    \usepackage{{graphicx}}  % Ulepszona obsługa grafiki.
    \usepackage{{booktabs}}  % Profesjonalnie wyglądające tabele.
    \usepackage[margin=1in]{{geometry}}  % Dostosowanie wymiarów strony.
    \usepackage{{amsmath}}  % Zaawansowane polecenia matematyczne.
    \usepackage{{amssymb}}  % Dodatkowe symbole matematyczne.
    \usepackage{{amsfonts}}  % Wsparcie dla czcionek matematycznych.
    \usepackage{{lipsum}}  % Generowanie tekstu zastępczego.
    \usepackage[skip=12pt, indent=0pt]{{parskip}}  % Kontrola odstępów między akapitami.
    \usepackage{{hyperref}}  % Hipertesty w dokumentach.
    \usepackage{{fancyhdr}}  % Niestandardowe nagłówki/stopki.

    \graphicspath{{{{{}}}}}

    \title{{{}}}
    \author{{{}}}
    \date{{\today}}

    \begin{{document}}
    \maketitle

    \section{{Section}}\label{{sec:1}}

    In the section \ref{{sec:1}}.
    \lipsum[1]

    $$\frac{{1}}{{n}} \sum_{{i=1}}^n x$$

    \lipsum[2]

    {}

    \end{{document}}
            ]],
      { i(1, "article"), i(2, "./img"), i(3, "This is a test document"), i(4, "Jan Kowalski"), i(0) }
    )
  ),
}
