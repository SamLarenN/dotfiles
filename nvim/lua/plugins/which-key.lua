vim.pack.add { 'https://github.com/folke/which-key.nvim' }

local wk = require('which-key')

wk.setup()

wk.add({
  { '<leader>c', group = 'Code' },
  { '<leader>d', group = 'Debug' },
  { '<leader>g', group = 'Git' },
  { '<leader>n', group = 'Notes' },
  { '<leader>s', group = 'Search' },
  { '<leader>t', group = 'Test' },
{ '<leader>u', group = 'UI' },
  { '<leader>w', group = 'Windows' },

  -- Visual mode groups
  { '<leader>h', group = 'Git Hunks', mode = 'v' },
})
