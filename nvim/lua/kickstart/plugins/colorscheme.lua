return {
  {
    'catppuccin/nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    name = 'catppuccin',
    -- you can do it like this with a config function
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
        transparent_background = true,
      }
      vim.cmd 'colorscheme catppuccin-frappe'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    config = function()
      require('github-theme').setup {
        options = {
          transparent = true,
        },
      }
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    config = function()
      require('gruvbox').setup {
        transparent_mode = true,
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    --init = function()
    --  vim.cmd.colorscheme 'oxocarbon'
    --  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    --  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    --  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    --end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.g.zenbones_darken_comments = 45
    --   vim.cmd.colorscheme 'zenbones'
    --   vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    --   vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    --   vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    -- end,
  },

  {
    'alligator/accent.vim',
    lazy = false,
    priority = 1000,
    --    init = function()
    --      vim.g.accent_colour = 'yellow' -- Options: 'yellow', 'orange', 'red', 'green', 'blue', 'magenta', 'cyan'
    --      vim.g.accent_darken = 0 -- Set to 1 to darken background and text colors
    --      vim.g.accent_invert_status = 0 -- Set to 1 to invert status line text colors
    --      vim.g.accent_auto_cwd_colour = 0 -- Set to 1 for directory-based accent color
    --      vim.g.accent_no_bg = 1 -- Set to 1 to disable background color changes
    --
    --      -- Apply the colorscheme
    --      vim.cmd 'colorscheme accent'
    --    end,
  },
  {
    'huyvohcmc/atlas.vim',
    lazy = false,
    priority = 1000,
    init = function()
      --vim.cmd 'colorscheme atlas'
    end,
  },
  {
    'aditya-azad/candle-grey',
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd 'colorscheme candle-grey-transparent'
    -- end,
  },
  {
    'aliqyan-21/darkvoid.nvim',
    config = function()
      -- require('darkvoid').setup {
      --   transparent = true,
      -- }
      -- vim.cmd 'colorscheme darkvoid'
    end,
  },
}
