vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.cmdheight = 0
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    targets = {
      [''] = 'msg',
      empty = 'cmd',
      bufwrite = 'msg',
      confirm = 'cmd',
      emsg = 'pager',
      echo = 'msg',
      echomsg = 'msg',
      echoerr = 'pager',
      completion = 'cmd',
      list_cmd = 'pager',
      lua_error = 'pager',
      lua_print = 'msg',
      progress = 'pager',
      rpc_error = 'pager',
      quickfix = 'msg',
      search_cmd = 'cmd',
      search_count = 'cmd',
      shell_cmd = 'pager',
      shell_err = 'pager',
      shell_out = 'pager',
      shell_ret = 'msg',
      undo = 'msg',
      verbose = 'pager',
      wildlist = 'cmd',
      wmsg = 'msg',
      typed_cmd = 'cmd',
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
}

require 'config/options'
require 'config/keymaps'

require 'plugins/oil'
require 'plugins/autopairs'
require 'plugins/colorschemes'
require 'plugins/which-key'
require 'plugins/snacks'
require 'plugins/treesitter'
require 'plugins/mason'
require 'plugins/neotest'
require 'plugins/dap'
require 'plugins/gitsigns'
require 'plugins/flash'
require 'plugins/markdown'
require 'plugins/zk'
require 'plugins/blink'
require 'plugins/conform'
require 'plugins/lsp'
-- require 'plugins/noice'
require 'plugins/pack-ui'
