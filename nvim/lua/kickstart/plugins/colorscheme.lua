return {
  {
    'catppuccin/nvim',
    priority = 1001, -- Make sure to load this before all the other start plugins.
    name = 'catppuccin',
    -- you can do it like this with a config function
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
        transparent_background = true,
      }
    end,
    -- or just use opts table
    opts = {
      -- configurations
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
  },
  { 'ellisonleao/gruvbox.nvim', config = true },
}
