vim.pack.add { 'https://github.com/folke/snacks.nvim' }

local Snacks = require 'snacks'

Snacks.setup {
  input = { enabled = true },
  picker = {
    enabled = true,
    formatters = {
      file = {
        filename_first = true,
      },
    },
    icons = {
      files = {
        enabled = false,
      },
    },
  },
}

vim.keymap.set('n', '<leader><space>', function()
  Snacks.picker.smart()
end, { desc = 'Smart find files' })

vim.keymap.set('n', '<leader>sf', function()
  Snacks.picker.files {
    exclude = { 'vendor/*', 'node_modules/*' },
  }
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>sg', function()
  Snacks.picker.grep {
    exclude = { 'vendor/*', 'node_modules/*' },
  }
end, { desc = 'Grep' })

vim.keymap.set('n', 'gd', function()
  Snacks.picker.lsp_definitions()
end, { desc = 'Go to definition' })

vim.keymap.set('n', 'gr', function()
  Snacks.picker.lsp_references()
end, { desc = 'Go to references' })

vim.keymap.set('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'Lazygit' })

vim.keymap.set('n', '<leader>uc', function()
  Snacks.picker.colorschemes()
end, { desc = 'Colorscheme picker' })

vim.keymap.set('n', '<leader>uz', function()
  Snacks.zen()
end, { desc = 'Zen mode' })
