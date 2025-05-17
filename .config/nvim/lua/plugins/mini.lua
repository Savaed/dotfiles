return {
  {
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      -- require("lazyvim.util").on_load("which-key.nvim", function()
      --   ---@type table<string, string|table>
      --   local i = {
      --     [" "] = "Whitespace",
      --     ['"'] = 'Balanced "',
      --     ["'"] = "Balanced '",
      --     ["`"] = "Balanced `",
      --     ["("] = "Balanced (",
      --     [")"] = "Balanced ) including white-space",
      --     [">"] = "Balanced > including white-space",
      --     ["<lt>"] = "Balanced <",
      --     ["]"] = "Balanced ] including white-space",
      --     ["["] = "Balanced [",
      --     ["}"] = "Balanced } including white-space",
      --     ["{"] = "Balanced {",
      --     ["?"] = "User Prompt",
      --     _ = "Underscore",
      --     a = "Argument",
      --     b = "Balanced ), ], }",
      --     c = "Class",
      --     f = "Function",
      --     o = "Block, conditional, loop",
      --     q = "Quote `, \", '",
      --     t = "Tag",
      --   }
      --   local a = vim.deepcopy(i)
      --   for k, v in pairs(a) do
      --     a[k] = v:gsub(" including.*", "")
      --   end

      --   local ic = vim.deepcopy(i)
      --   local ac = vim.deepcopy(a)
      --   for key, name in pairs({ n = "Next", l = "Last" }) do
      --     i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
      --     a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
      --   end
      --   require("which-key").register({
      --     mode = { "o", "x" },
      --     i = i,
      --     a = a,
      --   })
      -- end)
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    -- keys = function(_, keys)
    --   -- Populate the keys based on the user's options
    --   -- local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
    --   -- local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    --   local mappings = {
    --     { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
    --     { opts.mappings.delete, desc = "Delete surrounding" },
    --     { opts.mappings.find, desc = "Find right surrounding" },
    --     { opts.mappings.find_left, desc = "Find left surrounding" },
    --     { opts.mappings.highlight, desc = "Highlight surrounding" },
    --     { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
    --   }
    --   mappings = vim.tbl_filter(function(m)
    --
    --     return m[1] and #m[1] > 0
    --   end, mappings)
    --   return vim.list_extend(mappings, keys)
    -- end, - asdf
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines` asdf
      },
    },
  },
  {

    "echasnovski/mini.diff",
    event = "VeryLazy",
    version = false,
    opts = {
      view = {
        style = "sign",
        signs = { add = "▌", delete = "▌", change = "▌" },
      },
    },
  },
  -- {
  --   "echasnovski/mini.comment",
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       custom_commentstring = function()
  --         return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "echasnovski/mini.bufremove",
  --   keys = {
  --     {
  --       "<leader>bd",
  --       function()
  --         local bd = require("mini.bufremove").delete
  --         if vim.bo.modified then
  --           local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
  --           if choice == 1 then -- Yes
  --             vim.cmd.write()
  --             bd(0)
  --           elseif choice == 2 then -- No
  --             bd(0, true)
  --           end
  --         else
  --           bd(0)
  --         end
  --       end,
  --       desc = "Delete Buffer",
  --     },
  --     -- stylua: ignore
  --     { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
  --   },
  -- },
  -- {
  --   "echasnovski/mini.indentscope",
  --   version = false, -- wait till new 0.7.0 release to put it back on semver
  --   enabled = false, -- look strange in python
  --   event = "VeryLazy",
  --   opts = {
  --     symbol = "|",
  --     options = { try_as_border = true },
  --   },
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = {
  --         "help",
  --         "alpha",
  --         "dashboard",
  --         "nvim-tree",
  --         "Trouble",
  --         "trouble",
  --         "lazy",
  --         "mason",
  --         "notify",
  --         "toggleterm",
  --         "lazyterm",
  --       },
  --       callback = function()
  --         vim.b.miniindentscope_disable = true
  --       end,
  --     })
  --   end,
  -- },
  -- { "echasnovski/mini.animate", version = false, opts = {} },
}
