return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				copilot_node_command = "node",
			})

			local util = require("copilot.util")
			local orig_get_editor_configuration = util.get_editor_configuration

			---@diagnostic disable-next-line: duplicate-set-field
			util.get_editor_configuration = function()
				local config = orig_get_editor_configuration()

				return vim.tbl_extend("force", config, {
					github = {
						copilot = {
							selectedCompletionModel = "gpt-4o-copilot",
						},
					},
				})
			end
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		opts = {
			provider = "copilot",
			-- cursor_applying_provider = "copilot/gpt-4.1",
			-- memory_summary_provider = "copilot/gpt-4.1",

			web_search_engine = {
				provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
				proxy = nil,     -- proxy support, e.g., http://127.0.0.1:7890
			},

			providers = {
				copilot = {
					endpoint = "https://api.githubcopilot.com/",
					model = "gpt-5-mini",
					proxy = nil,       -- [protocol://]host[:port] Use this proxy
					allow_insecure = false, -- Allow insecure server connections
					timeout = 30000,   -- Timeout in milliseconds
				},
			},

			input = {
				provider = "snacks",
				provider_opts = {
					title = "Avante Input",
					icon = " ",
					placeholder = "Enter your API key...",
				},
			},

			behaviour = {
				auto_suggestions = false,
				minimize_diffs = true,
				auto_apply_diff_after_generation = true,
			},

			system_prompt = function()
				local hub = require("mcphub").get_hub_instance()
				return hub and hub:get_active_servers_prompt() or ""
			end,
			-- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"echasnovski/mini.icons",
			"saghen/blink.cmp",
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						-- use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
			},
		},
	},
}
