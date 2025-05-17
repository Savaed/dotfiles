return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {
          layouts = {
            {
              elements = {
                { id = "breakpoints", size = 0.2 },
                { id = "stacks", size = 0.2 },
                { id = "scopes", size = 0.3 },
                { id = "watches", size = 0.3 },
              },
              size = 50,
              position = "left",
            },
            {
              elements = {
                "console",
                "repl",
              },
              size = 0.25,
              position = "bottom",
            },
          },
        },
      },
      { "theHamsta/nvim-dap-virtual-text", opts = { commented = true, virt_text_pos = "eol" } },
      { "nvim-neotest/nvim-nio" },
      { "LiadOz/nvim-dap-repl-highlights", opts = true },
    },
    keys = {
      {
        "<leader>dE",
        function()
          require("dapui").eval(vim.fn.input("[Expression] > "))
        end,
        desc = "Evaluate Input",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("[Condition] > "))
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle UI",
      },
      {
        "<leader>drtrtrt",
        function()
          require("dap").step_back()
        end,
        desc = "Step Back",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dd",
        function()
          require("dap").disconnect()
        end,
        desc = "Disconnect",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        mode = { "n", "v" },
        desc = "Evaluate",
      },
      {
        "<leader>dg",
        function()
          require("dap").session()
        end,
        desc = "Get Session",
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Hover Variables",
      },
      {
        "<leader>dS",
        function()
          require("dap.ui.widgets").scopes()
        end,
        desc = "Scopes",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause.toggle()
        end,
        desc = "Pause",
      },
      {
        "<leader>dq",
        function()
          require("dap").close()
        end,
        desc = "Quit",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<ESC>",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
    },
    opts = {
      setup = {},
    },
    config = function(plugin, opts)
      local icons = require("config.icons")

      -- Set up DAP icons and colors
      vim.fn.sign_define("DapBreakpoint", {
        text = icons.dap.Breakpoint,
        texthl = "DapBreakpointSymbol",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = icons.dap.Stopped,
        texthl = "DapStoppedSymbol",
        linehl = "DapStoppedLine",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = icons.dap.BreakpointCondition,
        texthl = "DapBreakpointSymbol",
        linehl = "",
        numhl = "",
      })

      -- Set colors for highlight groups
      vim.api.nvim_set_hl(0, "DapBreakpointSymbol", { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "DapStoppedSymbol", { fg = "#f9e2af" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "visual" })

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- set up debugger
      for k, _ in pairs(opts.setup) do
        opts.setup[k](plugin, opts)
      end

      -- Define the adapter for C#
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      config = function()
        local function continue()
          -- Reload './launch.json' on debug start command
          if vim.fn.filereadable(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs()
          end
          require("dap").continue()
        end

        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
        vim.keymap.set("n", "<F5>", continue)
      end,
    },
  },
}
