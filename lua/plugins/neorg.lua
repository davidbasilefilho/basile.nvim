return {
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neorg/neorg-telescope",
			"benlubas/neorg-interim-ls",
			{
				"jmbuhr/otter.nvim",
				ft = "norg",
				priority = 10,
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
					"folke/lazydev.nvim",
				},
			},
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},

					["core.integrations.otter"] = {},

					["core.integrations.telescope"] = {},

					["core.concealer"] = {},

					["core.keybinds"] = {
						config = {
							default_keybinds = true,
						},
					},

					["external.interim-ls"] = {
						config = {
							completion_provider = {
								enable = true,
								documentation = true,
								categories = false,
								people = {
									enable = false,
									path = "people",
								},
							},
						},
					},

					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/neorg",
								summaries = "~/neorg/summaries",
								todo = "~/neorg/todo",
								reminders = "~/neorg/reminders",
								knowledge = "~/neorg/wiki",
							},
							default_workspace = "notes",
						},
					},

					["core.qol.toc"] = {},

					["core.qol.todo_items"] = {},

					["core.export"] = {},

					["core.presenter"] = { config = { zen_mode = "zen-mode" } },

					["core.export.markdown"] = { extensions = "all" },

					["core.summary"] = { strategy = "default" },
				},
			})

			local function get_todos(dir, states)
				require("telescope.builtin").live_grep({ cwd = dir })
				vim.fn.feedkeys("^ *([*]+|[-]+) +[(]" .. states .. "[)]")
			end

			vim.keymap.set("n", "<leader>nft", function()
				get_todos("~/neorg/notes", "[^x_]")
			end, { desc = "[N]eorg [f]ind [T]odos" })

			vim.keymap.set(
				"n",
				"<leader>nw",
				"<cmd>Telescope neorg switch_workspace<CR>",
				{ desc = "[N]eorg [W]orkspaces" }
			)

			vim.keymap.set(
				"n",
				"<leader>nfn",
				"<cmd>Telescope neorg find_norg_files<CR>",
				{ desc = "[N]eorg [F]ind [N]org files" }
			)

			vim.keymap.set(
				"n",
				"<leader>nfh",
				"<cmd>Telescope neorg search_headings<CR>",
				{ desc = "[N]eorg [F]ind [H]eadings" }
			)

			vim.keymap.set("n", "<leader>np", "<cmd>Neorg presenter start<CR>", { desc = "[N]eorg [P]resent" })

			local function tangle_and_export()
				vim.schedule(function()
					vim.cmd("Neorg tangle current-file")
					vim.cmd("Neorg export to-file " .. vim.fn.expand("%:r") .. ".md markdown")
				end)
			end

			vim.api.nvim_create_user_command("TangleAndExport", tangle_and_export, {})

			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*.norg",
				callback = tangle_and_export,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*.norg",
				callback = function()
					vim.opt_local.tabstop = 2
					vim.opt_local.shiftwidth = 2
					vim.opt_local.expandtab = true
				end,
			})
		end,
	},
}
