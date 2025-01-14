return {
  'folke/zen-mode.nvim',
  config = function()
    local zenmode = require 'zen-mode'
    zenmode.setup {}

    vim.keymap.set('n', '<leader>tz', '<cmd>ZenMode<CR>', { desc = '[T]oggle Zen Mode' })
  end,
}
