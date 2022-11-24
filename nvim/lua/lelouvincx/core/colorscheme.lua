-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme zephyr")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end

-- make transparent with terminal's theme
vim.cmd([[ hi Normal ctermbg=NONE guibg=NONE ]])
vim.cmd([[ highlight clear LineNr ]])
vim.cmd([[ highlight clear SignColumn ]])
