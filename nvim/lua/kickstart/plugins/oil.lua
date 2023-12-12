return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      keymaps = {
        ['q'] = 'actions.close',
        ['<BS>'] = 'actions.parent',
      },
    }
  end,
  keys = {
    { '=', '<cmd>Oil --float<cr>', mode = 'n', desc = 'Open Filesystem' },
    { '-', '<cmd>Oil<cr>', mode = 'n', desc = 'Open Floating Filesystem' },
  },
}
