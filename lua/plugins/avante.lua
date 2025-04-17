return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				copilot_node_command = "node"
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
			auto_suggestions_provider = "copilot",
			cursor_applying_provider = "copilot",
			memory_summary_provider = "copilot_gpt_4o",

			suggestion = {
				debounce = 1000,
				throttle = 1000,
			},

			web_search_engine = {
				provider = "tavily",
				providers = {
					api_key_name = "TAVILY_API_KEY",
					extra_request_body = {
						include_answer = "basic",
					},
					format_response_body = function(body) return body.answer, nil end,
				}
			},

			copilot = {
				endpoint = "https://api.githubcopilot.com/",
				model = "o4-mini",
				proxy = nil,        -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				timeout = 30000,    -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 20480,
			},

			vendors = {
				copilot_claude = {
					__inherited_from = "copilot",
					model = "claude-3.7-sonnet",
				},
				copilot_claude_thinking = {
					__inherited_from = "copilot",
					model = "claude-3.7-sonnet-thought",
				},
				copilot_o1 = {
					__inherited_from = "copilot",
					model = "o1",
				},
				copilot_o3_mini = {
					__inherited_from = "copilot",
					model = "o3-mini",
				},
				copilot_gemini = {
					__inherited_from = "copilot",
					model = "gemini-2.0-flash-001",
				},
				copilot_gpt_4o = {
					__inherited_from = "copilot",
					model = "gpt-4o-2024-11-20",
				},
			},

			behaviour = {
				auto_suggestions = false,
				enable_cursor_planning_mode = true,
				minimize_diffs = true,
			},
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
			'saghen/blink.cmp',
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
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
