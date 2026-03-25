-- Diagnostics
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = false })
  vim.schedule(function() vim.diagnostic.open_float(nil, { focus = false }) end)
end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = false })
  vim.schedule(function() vim.diagnostic.open_float(nil, { focus = false }) end)
end, { desc = 'Prev diagnostic' })

-- Keep visual selection when indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Clear search highlights and messages
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr><cmd>echo ""<cr>', { desc = 'Clear hlsearch and messages' })

-- LSP
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>cs', function() require('snacks').picker.lsp_symbols() end, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>cd', function() vim.diagnostic.open_float(nil, { focus = false }) end, { desc = 'Line diagnostics' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Window splits and management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Equalize windows' })

-- Resize mode
local resize_mode_active = false
local resize_keys = { 'h', 'j', 'k', 'l', '<Esc>' }

local function exit_resize_mode()
  for _, key in ipairs(resize_keys) do
    pcall(vim.keymap.del, 'n', key)
  end
  resize_mode_active = false
  vim.notify('Resize mode off', vim.log.levels.INFO)
end

vim.keymap.set('n', '<leader>wr', function()
  if resize_mode_active then
    exit_resize_mode()
    return
  end
  resize_mode_active = true
  vim.keymap.set('n', 'h', '5<C-w><', { nowait = true })
  vim.keymap.set('n', 'l', '5<C-w>>', { nowait = true })
  vim.keymap.set('n', 'j', '5<C-w>+', { nowait = true })
  vim.keymap.set('n', 'k', '5<C-w>-', { nowait = true })
  vim.keymap.set('n', '<Esc>', exit_resize_mode, { nowait = true })
  vim.notify('Resize mode on — hjkl to resize, <Esc> to exit', vim.log.levels.INFO)
end, { desc = 'Resize mode' })
