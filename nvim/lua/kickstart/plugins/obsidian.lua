return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',

  opts = {
    workspaces = {
      {
        name = 'work',
        path = '~/Documents/Obsidian/OSTTRA',
      },
    },
    daily_notes = {
      folder = 'Daily Log',
      template = 'Daily.md',
    },
    templates = {
      subdir = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      substitutions = {
        time = function()
          return os.date('%H:%M:%S', os.time())
        end,
      },
    },
  },

  keys = {
    {
      '<leader>nn',
      function()
        local choices = {
          { name = 'Fleeting Note', template = '', dir = 'Fleeting\\ Notes' },
          { name = 'Zettel Idea', template = 'Core\\ Zettel\\ idea.md', dir = 'Zettelkasten' },
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
            input = input .. '.md'
            local cmd = string.format('Obsidian new %s/%s', choice.dir, input)
            if choice.template ~= '' then
              cmd = string.format('Obsidian new_from_template %s/%s %s', choice.dir, input, choice.template)
            end
            vim.cmd(cmd)
          end)
        end)
      end,
      desc = 'New note (choose type)',
    },
    {
      '<leader>ns',
      '<cmd>Obsidian search<cr>',
      desc = 'Grep',
    },
    {
      '<leader>nf',
      '<cmd>Obsidian quick_switch<cr>',
      desc = 'Search',
    },
    { '<leader>nd', ':Obsidian today<cr>', desc = 'Daily' },
    { '<leader>nt', ':Obsidian today 1<cr>', desc = 'Tomorrow daily' },
    { '<leader>ny', ':Obsidian today -1<cr>', desc = 'Yesterday daily' },
    { '<leader>gd', ':Obsidian follow_link <cr>', desc = 'Follow link' },
  },
}
