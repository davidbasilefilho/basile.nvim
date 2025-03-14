return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	keys = {
		{ "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "x", desc = "[C]odeSnap into [C]lipboard" },
		{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "[C]odeSnap [S]ave" },
	},
	opts = {
		save_path = "~/Pictures",
		has_breadcrumbs = true,
		bg_theme = "bamboo",
	},
}
