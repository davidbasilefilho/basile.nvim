return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local snacks = require("snacks")
		local harpoon = require("harpoon")
		harpoon:setup({})

		local function generate_harpoon_picker()
			local file_paths = {}
			for _, item in ipairs(harpoon:list().items) do
				table.insert(file_paths, {
					text = item.value,
					file = item.value
				})
			end
			return file_paths
		end

		vim.keymap.set("n", "<leader>he", function()
			snacks.picker({
				finder = generate_harpoon_picker,
				win = {
					input = {
						keys = {
							["dd"] = { "harpoon_delete", mode = { "n", "x" } }
						}
					},
					list = {
						keys = {
							["dd"] = { "harpoon_delete", mode = { "n", "x" } }
						}
					},
				},
				actions = {
					harpoon_delete = function(picker, item)
						local to_remove = item or picker:selected()
						table.remove(harpoon:list().items, to_remove.idx)
						picker:find({
							refresh = true -- refresh picker after removing values
						})
					end
				},
			})
		end)

		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add current file to harpoon" })

		vim.keymap.set("n", "<leader>hh", function()
			harpoon:list():select(1)
		end, { desc = "Select harpoon item 1" })

		vim.keymap.set("n", "<leader>ht", function()
			harpoon:list():select(2)
		end, { desc = "Select harpoon item 2" })

		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():select(3)
		end, { desc = "Select harpoon item 3" })

		vim.keymap.set("n", "<leader>hs", function()
			harpoon:list():select(4)
		end, { desc = "Select harpoon item 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hrp", function()
			harpoon:list():prev()
		end, { desc = "Select previous harpoon item" })

		vim.keymap.set("n", "<leader>hrn", function()
			harpoon:list():next()
		end, { desc = "Select next harpoon item" })
	end,
}
