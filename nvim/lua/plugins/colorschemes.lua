vim.pack.add { 'https://github.com/morhetz/gruvbox' }
vim.pack.add { 'https://github.com/projekt0n/github-nvim-theme' }
require('github-theme').setup({
  options = {
    transparent = true
  }
})

vim.cmd('colorscheme github_dark')
