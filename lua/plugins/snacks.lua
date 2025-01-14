return {
  'folke/snacks.nvim',
  dependencies = {
    'folke/edgy.nvim',
    opts = function(_, opts)
      for _, pos in ipairs { 'top', 'bottom', 'left', 'right' } do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = 'snacks_terminal',
          size = { height = 0.4 },
          title = '%{b:snacks_terminal.id}: %{b:term_title}',
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == 'editor'
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
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
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true, animate = { easing = 'linear', duration = { total = 200 } } },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      scope = { enabled = true },
    }

    -- Keymaps
    map('t', '<C-q>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

    -- map('n', '<leader>tz', function()
    --   snacks.zen()
    -- end, { desc = '[T]oggle [Z]en mode' })

    map({ 'n', 'v' }, '<leader>tt', function()
      snacks.terminal(nil, { win = { height = 0.2, relative = 'editor' } })
    end, { desc = '[T]oggle [T]erminal' })

    map({ 'n', 'v' }, '<leader>tr', function()
      snacks.terminal.open({ 'bash' }, { win = { position = 'right', relative = 'editor' } })
    end, { desc = '[T]oggle [R]ight terminal' })

    map({ 'n', 'v' }, '<leader>tf', function()
      snacks.terminal 'bash'
    end, { desc = '[T]oggle [F]loating terminal' })
  end,
}
