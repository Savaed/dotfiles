return {
  {
    "folke/snacks.nvim",
    keys = {
      -- Top Pickers & Explorer
      -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files", },
      -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers", },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History", },
      -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History", },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      -- find
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers({
            -- I always want my buffers picker to start in normal mode
            on_show = function()
              vim.cmd.stopinsert()
            end,
            finder = "buffers",
            format = "buffer",
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
            win = {
              input = {
                keys = {
                  ["d"] = "bufdelete",
                },
              },
              list = { keys = { ["d"] = "bufdelete" } },
            },
            -- In case you want to override the layout for this keymap
            -- layout = "ivy",
          })
        end,
        desc = "Buffers",
      },
      -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File", },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects", },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      -- git
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line", },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      -- Grep
      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines", },
      -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers", },
      -- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep", },
      {
        "<leader>fs",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      -- search
      -- { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers", },
      -- { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History", },
      -- { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds", },
      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines", },
      -- { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History", },
      -- { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands", },
      {
        "<leader>d",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>D",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      -- { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages", },
      -- { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights", },
      -- { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons", },
      -- { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps", },
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>xl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      -- { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks", },
      -- { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages", },
      -- { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec", },
      {
        "<leader>xx",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      -- { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume", },
      -- { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History", },
      -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes", },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gi",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gt",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto [t]ype Definition",
      },
      -- {
      --   "<leader>fs",
      --   function()
      --     Snacks.picker.lsp_symbols()
      --   end,
      --   desc = "LSP Symbols",
      -- },
      {
        "<leader>fS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      -- I use this keymap with mini.files, but snacks  was taking over
      -- https://github.com/folke/snacks.nvim/discussions/949

      -- -- List git branches with Snacks_picker to quickly switch to a new branch
      {
        "<M-b>",
        function()
          Snacks.picker.git_branches({
            layout = "select",
          })
        end,
        desc = "Branches",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
      },

      -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, desc("Code actions", bufnr))
      -- keymap.set("n", "<leader>rr", vim.lsp.buf.rename, desc("Rename symbol under cursor", bufnr))
      -- -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", desc("Buffer diagnostics", bufnr)) -- show  diagnostics for file
      -- -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, desc("Line diagnostics", bufnr)) -- show diagnostics for line
      -- keymap.set("n", "[d", vim.diagnostic.goto_prev, desc("Previous diagnostics", bufnr))
      -- keymap.set("n", "]d", vim.diagnostic.goto_next, desc("Next diagnostics", bufnr))
      -- keymap.set("n", "K", vim.lsp.buf.hover, desc("Documentation", bufnr))
      -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", desc("Restart LSP", bufnr))
    },
    opts = {
      scope = {
        enabled = true,
      },
      indent = { only_scope = true },
      --explorer = {},
      -- Documentation for the picker
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
        -- file was always showing at the top, I needed a way to decrease its
        -- score, in frecency you could use :FrecencyDelete to delete a file
        -- from the database, here you can decrease it's score
        transform = function(item)
          if not item.file then
            return item
          end
          -- Demote the "lazyvim" keymaps file:
          if item.file:match("lazyvim/lua/config/keymaps%.lua") then
            item.score_add = (item.score_add or 0) - 30
          end
          -- Boost the "neobean" keymaps file:
          -- if item.file:match("neobean/lua/config/keymaps%.lua") then
          --   item.score_add = (item.score_add or 0) + 100
          -- end
          return item
        end,
        -- In case you want to make sure that the score manipulation above works
        -- or if you want to check the score of each file
        debug = {
          scores = false, -- show scores in the list
        },
        -- I like the "ivy" layout, so I set it as the default globaly, you can
        -- still override it in different keymaps
        layout = {
          preset = "ivy",
          -- When reaching the bottom of the results in the picker, I don't want
          -- it to cycle and go back to the top
          cycle = true,
        },
        layouts = {
          -- I wanted to modify the ivy layout height and preview pane width,
          -- this is the only way I was able to do it
          -- NOTE: I don't think this is the right way as I'm declaring all the
          -- other values below, if you know a better way, let me know
          --
          -- Then call this layout in the keymaps above
          -- got example from here
          -- https://github.com/folke/snacks.nvim/discussions/468
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
          -- I wanted to modify the layout width
          --
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              -- I'm used to scrolling like this in LazyGit
              ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["L"] = { "preview_scroll_right", mode = { "i", "n" } },

              ["<BS>"] = "explorer_up",
              ["l"] = "confirm",
              ["h"] = "explorer_close", -- close directory
              ["a"] = "explorer_add",
              ["d"] = "explorer_del",
              ["r"] = "explorer_rename",
              ["c"] = "explorer_copy",
              ["m"] = "explorer_move",
              ["o"] = "explorer_open", -- open with system application
              ["P"] = "toggle_preview",
              ["y"] = { "explorer_yank", mode = { "n", "x" } },
              ["p"] = "explorer_paste",
              ["u"] = "explorer_update",
              ["<c-c>"] = "tcd",
              ["<leader>/"] = "picker_grep",
              ["<c-t>"] = "terminal",
              ["."] = "explorer_focus",
              ["I"] = "toggle_ignored",
              ["H"] = "toggle_hidden",
              ["Z"] = "explorer_close_all",
              ["]g"] = "explorer_git_next",
              ["[g"] = "explorer_git_prev",
              ["]d"] = "explorer_diagnostic_next",
              ["[d"] = "explorer_diagnostic_prev",
              ["]w"] = "explorer_warn_next",
              ["[w"] = "explorer_warn_prev",
              ["]e"] = "explorer_error_next",
              ["[e"] = "explorer_error_prev",
            },
          },
        },
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
            truncate = 80,
          },
        },
      },
      -- Folke pointed me to the snacks docs
      -- https://github.com/LazyVim/LazyVim/discussions/4251#discussioncomment-11198069
      -- Here's the lazygit snak docs
      -- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
      lazygit = {
        theme = {
          selectedLineBgColor = { bg = "CursorLine" },
        },
        -- With this I make lazygit to use the entire screen, because by default there's
        -- "padding" added around the sides
        -- I asked in LazyGit, folke didn't like it xD xD xD
        -- https://github.com/folke/snacks.nvim/issues/719
        win = {
          -- -- The first option was to use the "dashboard" style, which uses a
          -- -- 0 height and width, see the styles documentation
          -- -- https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
          -- style = "dashboard",
          -- But I can also explicitly set them, which also works, what the best
          -- way is? Who knows, but it works
          width = 0,
          height = 0,
        },
      },
      notifier = {
        enabled = false,
        top_down = false, -- place notifications from top to bottom
      },
      -- This keeps the image on the top right corner, basically leaving your
      -- text area free, suggestion found in reddit by user `Redox_ahmii`
      -- https://www.reddit.com/r/neovim/comments/1irk9mg/comment/mdfvk8b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
      bigfile = {},
      image = {
        enabled = true,
        doc = {
          -- Personally I set this to false, I don't want to render all the
          -- images in the file, only when I hover over them
          -- render the image inline in the buffer
          -- if your env doesn't support unicode placeholders, this will be disabled
          -- takes precedence over `opts.float` on supported terminals
          inline = vim.g.neovim_mode == "skitty" and true or false,
          -- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          -- Sets the size of the image
          -- max_width = 60,
          -- max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
          -- max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
          max_width = vim.g.neovim_mode == "skitty" and 5 or 60,
          max_height = vim.g.neovim_mode == "skitty" and 2.5 or 30,
          -- max_height = 30,
          -- Apparently, all the images that you preview in neovim are converted
          -- to .png and they're cached, original image remains the same, but
          -- the preview you see is a png converted version of that image
          --
          -- Where are the cached images stored?
          -- This path is found in the docs
          -- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
          -- For me returns `~/.cache/neobean/snacks/image`
          -- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
        },
      },

      dashboard = {

        preset = {
          keys = {
            -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            -- {
            --   icon = " ",
            --   key = "c",
            --   desc = "Config",
            --   action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            -- },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "<esc>", desc = "Quit", action = ":qa" },
          },
          -- Font Name: ANSI Shadow
          -- https://patorjk.com/software/taag
          header = [[
      ███╗   ██╗███████╗ ██████╗ ██████╗ ███████╗ █████╗ ███╗   ██╗
      ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗████╗  ██║
      ██╔██╗ ██║█████╗  ██║   ██║██████╔╝█████╗  ███████║██╔██╗ ██║
      ██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██╔══╝  ██╔══██║██║╚██╗██║
      ██║ ╚████║███████╗╚██████╔╝██████╔╝███████╗██║  ██║██║ ╚████║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝

      [Linkarzu.com]
              ]],
        },
      },
    },
  },
}
