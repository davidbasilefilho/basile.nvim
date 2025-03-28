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
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			-- add any opts here
			provider = "copilot",
			auto_suggestions_provider = "copilot",
			suggestion = {
				debounce = 1000,
				throttle = 1000,
			},
			web_search_engine = {
				provider = "google",
				providers = {
					google = {
						api_key_name = os.getenv("GOOGLE_API_KEY"),
						engine_id_name = "neovim",
						extra_request_body = {},
						format_response_body = function(body)
							if body.items ~= nil then
								local jsn = vim
										.iter(body.items)
										:map(
											function(result)
												return {
													title = result.title,
													link = result.link,
													snippet = result.snippet,
												}
											end
										)
										:take(10)
										:totable()
								return vim.json.encode(jsn), nil
							end
							return "", nil
						end,
					},
				}
			},
			copilot = {
				endpoint = "https://api.githubcopilot.com/",
				model = "claude-3.5-sonnet",
				proxy = nil,        -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				timeout = 30000,    -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 32768,
			},

			ollama = {
				endpoint = "http://127.0.0.1:11434",
				model = "phi4",
				timeout = 30000, -- Timeout in milliseconds
				options = {
					temperature = 0,
					num_ctx = 4096,
				},
			},

			behaviour = {
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
			"hrsh7th/nvim-cmp",    -- autocompletion for avante commands and mentions
			"echasnovski/mini.icons",
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
