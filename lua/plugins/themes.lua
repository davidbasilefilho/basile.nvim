return {
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {},
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {},
	},
	{
		'olivercederborg/poimandres.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('poimandres').setup {
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			}
		end
	},
}
