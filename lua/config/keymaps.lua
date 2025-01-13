local map = vim.keymap.set
local noremap = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  map(mode, lhs, rhs, opts)
end

map('n', '<leader>ol', function()
  vim.cmd 'Lazy'
end, { desc = '[O]pen [L]azy.nvim' })

map('n', '<leader>om', function()
  vim.cmd 'Mason'
end, { desc = '[O]pen [M]ason' })

noremap('n', '<C-d>', '<C-d>zz')
noremap('n', '<C-u>', '<C-u>zz')
