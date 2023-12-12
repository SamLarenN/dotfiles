return {
  { 'ellisonleao/gruvbox.nvim' },
  { 'NLKNguyen/papercolor-theme' },
  {
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup {
        options = {
          transparent = vim.g.transparent_background,
        },
      }

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TransparentToggled',
        callback = function()
          require('github-theme').setup {
            options = {
              transparent = vim.g.transparent_background,
            },
          }
        end,
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {
        transparent_background = vim.g.transparent_background,
      }

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TransparentToggled',
        callback = function()
          require('catppuccin').setup {
            transparent_background = vim.g.transparent_background,
          }
        end,
      })
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --   vim.g.zenbones_darken_comments = 45
    --   vim.cmd.colorscheme 'zenburned'
    -- end,
  },

  -- Configure LazyVim to load gruvbox
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'github_dark',
    },
  },
}
