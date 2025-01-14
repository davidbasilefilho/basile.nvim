return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = function()
    local noice = require 'noice'
    noice.setup {
      notify = { enabled = false },
      messages = { enabled = false },
      presets = {
        bottom_search = true,   -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
}
