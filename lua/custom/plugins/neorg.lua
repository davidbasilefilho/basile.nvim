return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = '*', -- Pin Neorg to the latest stable release
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.concealer'] = {}, -- Allows for use of icons
        ['core.dirman'] = { -- Manage your directories with Neorg
          config = {
            workspaces = {
              neorg = '~/neorg',
            },
            default_workspace = 'neorg',
          },
        },
        ['core.export'] = {},
        ['core.export.markdown'] = { extensions = 'all' },
        ['core.summary'] = { strategy = 'default' },
      },
    }

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
  end,
}
