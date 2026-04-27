vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

local gitsigns = require 'gitsigns'

gitsigns.setup {}

-- visual mode
vim.keymap.set('v', '<leader>hs', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'Stage Hunk' })
vim.keymap.set('v', '<leader>hr', function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'Reset Hunk' })

-- normal mode
vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview Hunk' })
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff Against Index' })
vim.keymap.set('n', '<leader>gD', function()
  gitsigns.diffthis '@'
end, { desc = 'Diff Against Last Commit' })

vim.keymap.set('n', '<leader>gb', function()
  gitsigns.blame_line { full = true }
end, { desc = 'Blame Line' })

vim.keymap.set('n', '<leader>gB', function()
  gitsigns.blame()
end, { desc = 'Blame File' })
