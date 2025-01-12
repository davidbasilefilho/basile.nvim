return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = function()
    local noice = require 'noice'
    noice.setup {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true,
        -- command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    }

    local map = vim.keymap.set

    map('n', '<leader>md', '<cmd>NoiceDismiss<CR>', { desc = '[M]essages [D]ismiss' })
    map('n', '<leader>ms', '<cmd>NoiceTelescope<CR>', { desc = '[M]essages [S]earch' })
    map('n', '<leader>mh', '<cmd>NoiceAll<CR>', { desc = '[M]essages [H]istory' })
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
