local map = vim.keymap.set

map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next" })
map("n", "N", "Nzzzv", { desc = "Previous" })

-- greatest remaps ever
map("x", "p", [["_dP]], { desc = "Paste" })
map("n", "d", [["_d]], { desc = "Delete" })
map("n", "x", [["_x]], { desc = "Delete" })

map("i", "jk", "<Esc>", { desc = "Enter normal mode" })
map("i", "kj", "<Esc>", { desc = "Enter normal mode" })

-- map("n", "Q", "<nop>")

map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Previous autocompletion" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous autocompletion" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Quickfix, location list
-- map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "<leader>xx", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Split window
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>sh", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>sv", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>stv", "<C-w>t<C-w>H", { desc = "Change splits to vertical", remap = true })
map("n", "<leader>sth", "<C-w>t<C-w>K", { desc = "Change splits to horizontal", remap = true })
