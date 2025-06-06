local map = vim.keymap.set
local noremap = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = true
	opts.silent = true
	map(mode, lhs, rhs, opts)
end

-- Some stuff taken from the Primeagen
noremap("n", "<C-d>", "<C-d>zz")
noremap("n", "<C-u>", "<C-u>zz")

-- Visually move lines
noremap("v", "J", ":m '>+1<CR>gv=gv")
noremap("v", "K", ":m '<-2<CR>gv=gv")

-- Better join
noremap("n", "J", "mzJ`z")

-- Better search
noremap("n", "n", "nzzzv")
noremap("n", "N", "Nzzzv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Lazy
map("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "[L]a[Z]y" })
