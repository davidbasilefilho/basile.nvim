return {
	"marcinjahn/gemini-cli.nvim",
	cmd = "Gemini",
	keys = {
		{ "<leader>g/", "<cmd>Gemini toggle<cr>",   desc = "Toggle Gemini CLI" },
		{ "<leader>ga", "<cmd>Gemini ask<cr>",      desc = "Ask Gemini",       mode = { "n", "v" } },
		{ "<leader>gf", "<cmd>Gemini add_file<cr>", desc = "Add File" },

	},
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("gemini-cli").setup({
			auto_reload = true,

		})
	end,
}
