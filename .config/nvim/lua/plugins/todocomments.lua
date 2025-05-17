return {
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    -- optional = true,
    opts = {
      signs = false,
    },
    config = true,
    -- stylua: ignore
    keys = {
    { "<leader>fC", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    { "<leader>fc", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
}
