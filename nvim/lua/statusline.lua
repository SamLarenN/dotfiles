vim.cmd [[ 
    hi StatuslineLeft guifg=#66b2b2 guibg=NONE
    hi StatuslineRight guifg=#66b2b2 guibg=NONE
    hi StatuslineMiddle guibg=NONE
    hi StatuslineModified guifg=#66b2b2 guibg=NONE " Transparent highlight for modified flag
]]

local function mode()
  local modes = {
    n = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'V-LINE',
    [''] = 'V-BLOCK',
    c = 'COMMAND',
    R = 'R',
    t = 'TERMINAL',
  }
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(' %s ', modes[current_mode] or 'UNKNOWN')
end

local function get_git_branch()
  local branch = vim.b.gitsigns_head
  if branch == nil or branch == '' then
    return ''
  end
  return branch
end

local function git_branch()
  local branch = get_git_branch()
  if branch == '' then
    return ''
  end
  return string.format('  %s %%*', branch)
end

local function lsp_diagnostics()
  if not rawget(vim, 'lsp') then
    return ''
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  return string.format('  :%d  :%d  :%d  :%d ', errors, warnings, hints, info)
end

local function file_info()
  local filename = vim.fn.expand '%:t'
  if filename == '' then
    filename = '[No Name]'
  end

  local line = vim.fn.line '.'
  local total_lines = vim.fn.line '$'

  local position
  if line == 1 then
    position = '󰋇 Top'
  elseif line == total_lines then
    position = '󰋇 Bot'
  else
    position = string.format('󰋇 %d/%d', line, total_lines)
  end

  return position
end

local function left_island()
  return table.concat {
    '%#StatuslineLeft#',
    mode(),
    git_branch(),
    '%#StatuslineModified#',
    '%m',
    -- lsp_diagnostics(), -- Uncomment for lsp_diagnostics
  }
end

local function right_island()
  return table.concat {
    '%#StatuslineRight#',
    ' %f ',
    file_info(),
  }
end

function Statusline()
  return table.concat {
    '%#StatuslineLeft#',
    left_island(),
    '%#StatuslineMiddle#',
    '%=',
    right_island(),
  }
end

vim.opt.statusline = '%!v:lua.Statusline()'

-- Auto command to refresh statusline on buffer enter
vim.cmd [[
  augroup UpdateStatusline
    autocmd!
    autocmd BufEnter * lua vim.opt.statusline = "%!v:lua.Statusline()"
  augroup END
]]
