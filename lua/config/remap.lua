require("config.vscode.remap")
local map = vim.keymap.set

map("n", "<leader>ol", function()
	vim.cmd("Lazy")
end, { desc = "[O]pen [L]azy.nvim" })

map("n", "<leader>om", function()
	vim.cmd("Mason")
end, { desc = "[O]pen [M]ason" })
