vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	}
})

require("nvim-treesitter").install({
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
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" then
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
			end
		end
	end,
})

local SKIP_FT = {
	[""] = true,
	qf = true,
	help = true,
	man = true,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		local ft = vim.bo.filetype
		if SKIP_FT[ft] then
			return
		end

		local ok = pcall(vim.treesitter.start)
		if not ok then
			return
		end

		-- Only set expr folds when treesitter successfully started
		vim.wo[0].foldmethod = "expr"
		vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
