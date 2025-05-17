return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local lualine = require("lualine")
    local icons = require("config.icons")
    local lazy_status = require("lazy.status")

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        disabled_filetypes = {
          statusline = {
            "alpha",
            "lazy",
            "fugitive",
            "NvimTree",
            "Trouble",
          },
          winbar = {
            "help",
            "lazy",
            "alpha",
            "NvimTree",
            "Trouble",
          },
        },
        component_separators = "",
        section_separators = "",
        theme = "auto",
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = { "location" },
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    local function command(cmd, raw)
      local handle = assert(io.popen(cmd, "r"))
      local output = assert(handle:read("*a"))

      handle:close()

      if raw then
        return output
      end

      output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")

      return output
    end

    table.insert(config.sections.lualine_a, {
      "mode",
      fmt = function(str)
        return icons.ui.Vim .. str
      end,
    })

    table.insert(config.sections.lualine_b, {
      "branch",
      icon = icons.git.Branch,
      cond = conditions.check_git_workspace,
    })

    ins_left({
      "filename",
      cond = function()
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
        return filetype ~= "NvimTree" and conditions.buffer_not_empty()
      end,
    })

    -- ins_left {
    --   -- filesize component
    --   function()
    --     local function format_file_size(file)
    --       local size = vim.fn.getfsize(file)
    --       if size <= 0 then return '' end
    --       local sufixes = {'b', 'k', 'm', 'g'}
    --       local i = 1
    --       while size > 1024 do
    --         size = size / 1024
    --         i = i + 1
    --       end
    --       return string.format('%.1f%s', size, sufixes[i])
    --     end
    --     local file = vim.fn.expand('%:p')
    --     if string.len(file) == 0 then return '' end
    --     return format_file_size(file)
    --   end,
    --   condition = conditions.buffer_not_empty
    -- }

    ins_left({
      "diff",
      symbols = {
        added = icons.git.LineAdded .. " ",
        modified = icons.git.LineModified .. " ",
        removed = icons.git.LineRemoved .. " ",
      },
      cond = conditions.hide_in_width,
    })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    ins_right({
      lazy_status.updates,
      cond = lazy_status.has_updates,
      color = { fg = "#ff9e64" },
    })

    ins_right({
      "diagnostics",
      symbols = {
        error = icons.diagnostics.Error .. " ",
        warn = icons.diagnostics.Warning .. " ",
        info = icons.diagnostics.Information .. " ",
      },
    })

    ins_right({
      function()
        local python_path = os.getenv("VIRTUAL_ENV") .. "/bin/python"
        local python_version =
          command(python_path .. " -c 'import sys; print(\".\".join(map(str, sys.version_info[:3])))'", false)
        return "venv " .. python_version
      end,
      icon = icons.ui.Environment,
      cond = function()
        -- Display only if VIRTUAL_ENV points to executable
        local venv = os.getenv("VIRTUAL_ENV")
        return venv ~= nil and vim.fn.executable(venv .. "/bin/python") == 1
      end,
    })

    local function get_lsp_client_by_ft()
      local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      local clients = vim.lsp.get_clients()

      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end

      return nil
    end

    ins_right({
      -- Lsp server name .
      get_lsp_client_by_ft,
      icon = icons.ui.Factory,
      cond = function()
        return get_lsp_client_by_ft() ~= nil
      end,
    })

    -- Add components to right sections
    ins_right({
      "o:encoding", -- option component same as &encoding in viml
      upper = true, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
    })

    -- spaces
    ins_right({
      function()
        return vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
      end,
      icon = icons.ui.Tab,
    })

    ins_right({
      "fileformat",
      upper = true,
      icons_enabled = true,
    })

    ins_right({ "filetype", icons_enabled = true })

    ins_right({ "progress" })

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
