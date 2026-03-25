vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})

require('blink.cmp').setup({
  keymap = { preset = 'enter' },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = { enabled = true },
  },
  signature = { enabled = true },
})
