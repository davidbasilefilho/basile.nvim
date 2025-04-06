return {
	"folke/snacks.nvim",
	dependencies = {
		"folke/edgy.nvim",
		opts = function(_, opts)
			for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
				opts[pos] = opts[pos] or {}
				table.insert(opts[pos], {
					ft = "snacks_terminal",
					size = { height = 0.4 },
					title = "%{b:snacks_terminal.id}: %{b:term_title}",
					filter = function(_buf, win)
						return vim.w[win].snacks_win
								and vim.w[win].snacks_win.position == pos
								and vim.w[win].snacks_win.relative == "editor"
								and not vim.w[win].trouble_preview
					end,
				})
			end
		end,
	},
	priority = 1000,
	lazy = false,
	config = function()
		local snacks = require("snacks")
		local map = vim.keymap.set

		snacks.setup({
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			bufdelete = { enabled = true },
			win = { enabled = true },
			terminal = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			image = { enabled = true },
			picker = {
				win = {
					input = {
						keys = {
							["<a-s>"] = { "flash", mode = { "n", "i" } },
							["s"] = { "flash" },
						},
					},
				},
				actions = {
					flash = function(picker)
						require("flash").jump({
							pattern = "^",
							label = { after = { 0, 0 } },
							search = {
								mode = "search",
								exclude = {
									function(win)
										return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
									end,
								},
							},
							action = function(match)
								local idx = picker.list:row2idx(match.pos[1])
								picker.list:_move(idx, true, true)
							end,
						})
					end,
				},
			},
			rename = { enabled = true },
			notifier = { enabled = true },
			notify = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = {
				enabled = true,
				left = { 'git', "sign" },
				right = {},
			},
			words = { enabled = true },
			explorer = { enabled = true },
			scope = { enabled = true },
			lazygit = { enabled = true },
			zen = { enabled = true, win = { transparent = false, backdrop = { blend = 0 } } },
		})

		map('n', "<leader>e", snacks.explorer.open, { desc = "[E]xplorer" })
		map("n", "<leader>mh", snacks.notifier.show_history, { desc = "[M]essages [H]istory" })

		-- Pickers
		map('n', '<leader>sf', function() snacks.picker.files({ hidden = true }) end, { desc = "[S]earch [F]iles" })
		map('n', '<leader>sg', snacks.picker.grep, { desc = "[S]earch [G]rep" })
		map('n', '<leader>sb', snacks.picker.buffers, { desc = "[S]earch [B]uffers" })
		map('n', '<leader>sd', snacks.picker.diagnostics, { desc = "[S]earch [D]iagnostics" })
		map('n', '<leader>sw', snacks.picker.grep_word, { desc = "[S]earch [S]nippets" })
		map('n', '<leader>ss', snacks.picker.pickers, { desc = "[S]earch [P]ickers" })
		map('n', '<leader>sk', snacks.picker.keymaps, { desc = "[S]earch [K]eymaps" })
		map('n', '<leader>st', snacks.picker.colorschemes, { desc = "[S]earch [T]hemes" })
		map('n', '<leader>sh', snacks.picker.help, { desc = "[S]earch [H]elp Tags" })
		map('n', '<leader>s/', snacks.picker.grep_buffers, { desc = "[S]earch Grep Buffers" })

		-- LSP pickers
		map('n', 'gd', snacks.picker.lsp_definitions, { desc = "[G]o to [D]efinition" })
		map('n', "grr", snacks.picker.lsp_references, { desc = "[G]o to [R]eferences" })
		map('n', 'gI', snacks.picker.lsp_implementations, { desc = "[G]o to [I]mplementation" })
		map('n', '<leader>D', snacks.picker.lsp_type_definitions, { desc = "Type [D]efinition" })
		map('n', '<leader>ds', snacks.picker.lsp_symbols, { desc = "[D]ocument [S]ymbols" })
		map('n', '<leader>ws', snacks.picker.lsp_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })

		-- Lazygit
		map('n', '<leader>lg', snacks.lazygit.open, { desc = "[L]azy[G]it" })

		-- Zen
		map('n', '<leader>tz', function() snacks.zen() end, { desc = "[T]oggle [Z]en" })

		-- bufdelete
		map('n', '<C-x>x', function() snacks.bufdelete.delete() end, { desc = "Buffer delete" })
		map('n', '<C-x>a', function() snacks.bufdelete.all() end, { desc = "Buffer delete [A]ll" })
		map('n', '<C-x>o', function() snacks.bufdelete.other() end, { desc = "Buffer delete [O]ther" })
	end,
}
