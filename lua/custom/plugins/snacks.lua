return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    local snacks = require 'snacks'
    local map = vim.keymap.set

    snacks.setup {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      win = { enabled = true },
      terminal = { enabled = true },
      indent = { enabled = true },
      lazygit = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scope = { enabled = true },
    }

    -- Keymaps

    map({ 'n', 'v' }, '<leader>l', function()
      Snacks.lazygit()
    end, { desc = '[L]azygit' })

    map({ 'n', 'v' }, '<leader>tt', function()
      snacks.terminal.open(nil)
    end, { desc = '[T]oggle [T]erminal' })

    map({ 'n', 'v' }, '<leader>tr', function()
      snacks.terminal.open(nil, { win = { position = 'right' } })
    end, { desc = '[T]oggle [R]ight terminal' })

    map({ 'n', 'v' }, '<leader>tf', function()
      snacks.terminal.open 'bash'
    end, { desc = '[T]oggle [F]loating terminal' })
  end,
}
