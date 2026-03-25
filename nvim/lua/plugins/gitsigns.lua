vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

local gitsigns = require('gitsigns')

gitsigns.setup { }

-- visual mode
vim.keymap.set('v', '<leader>hs', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'stage git hunk' })
vim.keymap.set('v', '<leader>hr', function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'reset git hunk' })

-- normal mode
vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
vim.keymap.set('n', '<leader>gD', function()
  gitsigns.diffthis '@'
end, { desc = 'git [D]iff against last commit' })

