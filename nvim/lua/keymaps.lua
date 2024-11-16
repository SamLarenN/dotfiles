-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

---- resizing splits
vim.keymap.set({ 'n', 'v' }, '<C-Left>', function()
  require('smart-splits').resize_left()
end)
vim.keymap.set({ 'n', 'v' }, '<C-Down>', function()
  require('smart-splits').resize_down()
end)
vim.keymap.set({ 'n', 'v' }, '<C-Up>', function()
  require('smart-splits').resize_up()
end)
vim.keymap.set({ 'n', 'v' }, '<C-Right>', function()
  require('smart-splits').resize_right()
end)
---- moving between splits
vim.keymap.set({ 'n', 'v' }, '<C-h>', function()
  require('smart-splits').move_cursor_left()
end)
vim.keymap.set({ 'n', 'v' }, '<C-j>', function()
  require('smart-splits').move_cursor_down()
end)
vim.keymap.set({ 'n', 'v' }, '<C-k>', function()
  require('smart-splits').move_cursor_up()
end)
vim.keymap.set({ 'n', 'v' }, '<C-l>', function()
  require('smart-splits').move_cursor_right()
end)

-- Persistence, session manager
-- load the session for the current directory
vim.keymap.set('n', '<leader>qs', function()
  require('persistence').load()
end, { desc = 'Restore session' })

-- select a session to load
vim.keymap.set('n', '<leader>qS', function()
  require('persistence').select()
end, { desc = 'Select session' })

-- load the last session
vim.keymap.set('n', '<leader>ql', function()
  require('persistence').load { last = true }
end, { desc = 'Load last session' })

-- Diagnostics keymaps
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next() -- Go to the next diagnostic
  vim.diagnostic.open_float(nil, { -- Open a floating window with the diagnostic info
    focus = false, -- Keep focus on the main buffer
    scope = 'line', -- Show only the diagnostic on the current line
  })
end, { desc = 'Show next diagnostic' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev() -- Go to the next diagnostic
  vim.diagnostic.open_float(nil, { -- Open a floating window with the diagnostic info
    focus = false, -- Keep focus on the main buffer
    scope = 'line', -- Show only the diagnostic on the current line
  })
end, { desc = 'Show prev diagnostic' })

-- Visually select same lines after indenting using '<', '>'
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- Default to global marks
-- Ex. ma -> mA
function SetGlobalMark()
  local char = vim.fn.nr2char(vim.fn.getchar())
  if char:match '%l' then
    vim.cmd('normal! m' .. char:upper())
  else
    vim.cmd('normal! m' .. char)
  end
end

vim.api.nvim_set_keymap('n', 'm', [[<Cmd>lua SetGlobalMark()<CR>]], { noremap = true, silent = true })

-- Remap the ' command in normal mode
-- Ex. 'a -> 'A
function JumpToGlobalMark()
  local char = vim.fn.nr2char(vim.fn.getchar())
  if char:match '%l' then
    vim.cmd("normal! '" .. char:upper())
  else
    vim.cmd("normal! '" .. char)
  end
end

vim.api.nvim_set_keymap('n', "'", [[<Cmd>lua JumpToGlobalMark()<CR>]], { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
