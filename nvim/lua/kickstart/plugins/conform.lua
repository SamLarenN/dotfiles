return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>uf',
        function()
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
            print 'Autoformat enabled'
          else
            vim.g.disable_autoformat = true
            print 'Autoformat disabled'
          end
        end,
        desc = 'Toggle autoformat',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 5000,
          lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofumpt' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        clojure = { 'cljfmt' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        json = { 'prettierd' },
      },
      -- Custom formatter configurations
      formatters = {
        ruff_format = {
          args = { 'format', '--line-length', '120', '--stdin-filename', '$FILENAME', '-' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
