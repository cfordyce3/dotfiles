local o = vim.o

-- cursor and mouse
o.guicursor = ""
o.cursorline = true
o.mouse = 'a'

-- line numbers
vim.wo.number = true
o.relativenumber = true
o.signcolumn = "yes"

-- OS clipboard
vim.opt.clipboard = 'unnamedplus'
vim.g.clipboard = 'wl-copy'

-- lines
o.wrap = false
o.linebreak = true
o.scrolloff = 8
o.sidescrolloff = 8

-- tabs
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.autoindent = true
o.smarttab = true

-- search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

-- appearance
o.termguicolors = true
o.background = "dark"

-- comment options
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- backspace
o.backspace = "indent,eol,start"

-- random
o.updatetime = 300





---------------------------
--- CUSTOM AUTOCOMMANDS ---
---------------------------

-- highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd R",
})
