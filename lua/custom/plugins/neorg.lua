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
              my_workspace = '~/neorg',
            },
          },
        },
      },
      ['core.export'] = {},
      ['core.export.markdown'] = {},
      ['core.summary'] = { strategy = 'default' },
    }

    local function tangle_and_export()
      vim.schedule(function()
        require('neorg.modules.tangle').tangle()
        require('neorg.export').export 'markdown'
      end)
    end

    vim.api.nvim_create_user_command('TangleAndExport', tangle_and_export, {})

    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = '*.norg',
      callback = tangle_and_export,
    })
  end,
}
