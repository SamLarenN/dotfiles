return {
  'zk-org/zk-nvim',
  version = '*',
  lazy = false,
  config = function()
    require('zk').setup {
      picker = 'snacks_picker',
    }
  end,
  keys = {
    {
      '<leader>nd',
      ':ZkNew {group = "journal"}<cr>',
      desc = 'New daily note',
    },
    {
      '<leader>nn',
      function()
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

          -- Ask user for title
          vim.ui.input({ prompt = 'Title: ' }, function(input)
            if not input or input == '' then
              return
            end
            local cmd = string.format('ZkNew {title = "%s", group = "%s"}', input, choice.note_type)
            vim.cmd(cmd)
          end)
        end)
      end,
      desc = 'New note',
    },
    {
      '<leader>nf',
      ':ZkNotes<cr>',
      desc = 'Search notes',
    },
    {
      '<leader>nt',
      ':ZkTags<cr>',
      desc = 'Search notes by tags',
    },
    {
      '<leader>nb',
      ':ZkBacklinks<cr>',
      desc = 'Find backlinks',
    },
    {
      '<leader>nl',
      ':ZkInsertLink<cr>',
      desc = 'Insert link',
    },
  },
}
