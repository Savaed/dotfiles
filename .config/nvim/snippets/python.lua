local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local r = require("luasnip.extras").rep

return {
  s(
    { trig = "def", desc = "Python normal or async function" },
    fmt(
      "{}def {}({}) -> {}:\n\t{}",
      { c(1, { t(""), t("async") }), i(2, "function_name"), i(3), i(4, "None"), i(0, "...") }
    )
  ),

  s(
    { trig = "test", desc = "Pytest test function" },
    fmt(
      [[
            def test_{}__{}({}) -> None:
                """Test that {}."""
                {}
      ]],
      {
        i(1, "function"),
        i(2, "case"),
        i(3),
        i(4),
        i(0, "..."),
      }
    )
  ),

  s(
    { trig = "testa", desc = "Pytest async test function" },
    fmt(
      [[
            @pytest.mark.asyncio
            async def test_{}__{}({}) -> None:
                """Test that {}."""
                {}
            ]],
      {
        i(1, "function"),
        i(2, "case"),
        i(3),
        i(4),
        i(0, "..."),
      }
    )
  ),

  s(
    { trig = "timer", desc = "Time performance benchmark" },
    fmt(
      [[
            from timeit import default_timer as timer

            start = timer()

            {}

            end = timer()

            elapsed_seconds = end - start
            print(f"{{elapsed_seconds=}}")
            ]],
      {
        i(0),
      }
    )
  ),

  s(
    { trig = "ifname", desc = "Python main() function" },
    fmt(
      [[
            def main({}) -> int:
                {}
                return 0

            if __name__ == "__main__":
                raise SystemExit(main())
            ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    { trig = "ifnamea", desc = "Python main() async function" },
    fmt(
      [[
            import asyncio

            async def main({}) -> int:
                {}
                return 0

            if __name__ == "__main__":
                raise SystemExit(asyncio.run(main()))
            ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s(
    { trig = "aoc", desc = "Advent If Code puzzle tests" },
    fmt(
      [[
        from pathlib import Path


        def {}({}) -> {}:
            {} 

        assert {}("{}") == {}

        input_path = Path(__file__).parent / "input.txt"
        x = {}(input_path.read_text())
        print(x)
        ]],
      {
        i(1),
        i(2),
        i(3),
        i(0),
        r(1),
        i(4),
        i(5),
        r(1),
      }
    )
  ),
  s(
    { trig = "cudatestpytorch", desc = "Test GPUs availability on PyTorch" },
    fmt(
      [[
        import torch

        assert torch.cuda.is_available()
        print(f"GPUs available. Device count: {{torch.cuda.device_count()}}")

        A = torch.tensor([1.0, 2.0, 3.0], device="cuda")
        B = torch.tensor([1.0, 2.0, 3.0], device="cuda")
        C = A @ B

        assert torch.allclose(torch.tensor(14.0), C)
      ]],
      {}
    )
  ),
}
