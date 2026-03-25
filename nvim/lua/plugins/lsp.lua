vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }
require('lspconfig')

vim.lsp.enable {
  'yamlls',
  'gopls',
  'lua_ls',
  'vtsls',
  'ruff',
  'pyright',
}
