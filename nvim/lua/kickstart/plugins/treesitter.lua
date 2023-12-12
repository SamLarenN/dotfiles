return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function(_, _)
    local ensure_installed = {
      'bash',
      'c',
      'css',
      'diff',
      'python',
      'go',
      'gosum',
      'gomod',
      'html',
      'javascript',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'yaml',
    }

    -- make sure nvim-treesitter can load
    local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

    -- no nvim-treesitter, maybe fresh install
    if not ok then
      return
    end

    nvim_treesitter.install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

-- return {
--   {
--     'nvim-treesitter/nvim-treesitter',
--     lazy = false,
--     branch = 'main',
--     build = ':TSUpdate',
--     init = function()
--       local parser_installed = {
--         'bash',
--         'python',
--         'go',
--         'gomod',
--         'gosum',
--         'gowork',
--         'c',
--         'lua',
--         'vim',
--         'vimdoc',
--         'query',
--         'markdown_inline',
--         'markdown',
--         'typescript',
--         'tsx',
--       }
--
--       vim.defer_fn(function()
--         require('nvim-treesitter').install(parser_installed)
--       end, 1000)
--       require('nvim-treesitter').update()
--       require('nvim-treesitter').setup {
--         highlight = { enable = true },
--         indent = { enable = true },
--       }
--
--       -- auto-start highlights & indentation
--       vim.api.nvim_create_autocmd('FileType', {
--         desc = 'User: enable treesitter highlighting',
--         callback = function(ctx)
--           -- highlights
--           local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser
--
--           -- indent
--           local noIndent = {}
--           if hasStarted and not vim.list_contains(noIndent, ctx.match) then
--             vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--           end
--         end,
--       })
--     end,
--   },
-- }
