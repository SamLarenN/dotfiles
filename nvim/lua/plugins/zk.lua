vim.pack.add { 'https://github.com/zk-org/zk-nvim' }

require('zk').setup {
  picker = 'snacks_picker',
}

vim.keymap.set('n', '<leader>nd', ':ZkNew {group = "journal"}<cr>', { desc = 'New daily note' })
vim.keymap.set('n', '<leader>nn', function()
  local choices = {
    { name = 'Fleeting Note', note_type = 'fleeting' },
    { name = 'Zettelkasten', note_type = 'zettelkasten' },
  }

  vim.ui.select(choices, {
    prompt = 'Choose note type:',
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if not choice then
      return
    end

    vim.ui.input({ prompt = 'Title: ' }, function(input)
      if not input or input == '' then
        return
      end
      local cmd = string.format('ZkNew {title = "%s", group = "%s"}', input, choice.note_type)
      vim.cmd(cmd)
    end)
  end)
end, { desc = 'New note' })
vim.keymap.set('n', '<leader>sn', ':ZkNotes<cr>', { desc = 'Search notes' })
vim.keymap.set('n', '<leader>nt', ':ZkTags<cr>', { desc = 'Search notes by tags' })
vim.keymap.set('n', '<leader>nb', ':ZkBacklinks<cr>', { desc = 'Find backlinks' })
vim.keymap.set('n', '<leader>nl', ':ZkInsertLink<cr>', { desc = 'Insert link' })
