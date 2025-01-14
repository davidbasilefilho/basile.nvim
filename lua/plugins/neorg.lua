return {
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neorg/neorg-telescope',
      {
        'jmbuhr/otter.nvim',
        ft = 'norg',
        priority = 10,
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'folke/lazydev.nvim',
        },
      },
    },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.completion'] = { config = { engine = 'nvim-cmp', name = '[Norg]' } },
          ['core.integrations.nvim-cmp'] = {},
          ['core.integrations.otter'] = {},
          ['core.integrations.telescope'] = {},
          ['core.concealer'] = {},
          ['core.keybinds'] = {
            config = {
              default_keybinds = true,
            },
          },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/neorg/notes',
                wiki = '~/neorg/wiki',
                projects = '~/neorg/projects',
              },
              default_workspace = 'notes',
            },
          },
          ['core.qol.toc'] = {},
          ['core.qol.todo_items'] = {},
          ['core.export'] = {},
          ['core.presenter'] = { config = { zen_mode = 'zen-mode' } },
          ['core.export.markdown'] = { extensions = 'all' },
          ['core.summary'] = { strategy = 'default' },
        },
      }

      local _, neorg = pcall(require, 'neorg.core')
      local dirman = neorg.modules.get_module 'core.dirman'
      local function get_todos(dir, states)
        local current_workspace = dirman.get_current_workspace()
        local dir = current_workspace[2]
        require('telescope.builtin').live_grep { cwd = dir }
        vim.fn.feedkeys('^ *([*]+|[-]+) +[(]' .. states .. '[)]')
      end

      vim.keymap.set('n', '<leader>nt', function()
        get_todos('~/neorg/notes', '[^x_]')
      end, { desc = '[N]eorg find [T]odos' })

      vim.keymap.set('n', '<leader>nw', '<cmd>Telescope neorg switch_workspace<CR>', { desc = '[N]eorg [W]orkspaces' })

      vim.keymap.set('n', '<leader>np', '<cmd>Neorg presenter start<CR>', { desc = '[N]eorg [P]resent' })

      local function tangle_and_export()
        vim.schedule(function()
          vim.cmd 'Neorg tangle current-file'
          vim.cmd('Neorg export to-file ' .. vim.fn.expand '%:r' .. '.md markdown')
        end)
      end

      vim.api.nvim_create_user_command('TangleAndExport', tangle_and_export, {})

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*.norg',
        callback = tangle_and_export,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*.norg',
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
        end,
      })
    end,
  },
}
