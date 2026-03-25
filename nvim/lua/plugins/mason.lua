vim.pack.add { 'https://github.com/williamboman/mason.nvim' }

require('mason').setup()

local registry = require('mason-registry')
local ensure_installed = { 'lua-language-server', 'yaml-language-server', 'gopls', 'vtsls', 'ruff', 'pyright' }

for _, name in ipairs(ensure_installed) do
  local pkg = registry.get_package(name)
  if not pkg:is_installed() then
    pkg:install()
  end
end
