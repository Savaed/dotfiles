-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- LaTex Spellcheck
local spellcheck_group = vim.api.nvim_create_augroup("Spellcheck", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tex",
  group = spellcheck_group,
  callback = function()
    vim.opt_local.spelllang = "en_gb"
    vim.opt_local.spell = true
    vim.cmd("highlight SpellBad cterm=undercurl ctermfg=red guisp=red")
  end,
})
