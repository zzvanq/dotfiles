local function ToggleTransparency(normal)
	local current_normal = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	if current_normal ~= normal then
		vim.api.nvim_set_hl(0, "Normal", { bg = normal })
	else
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	end
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("silent! SupermavenStop")

		local normal = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		vim.keymap.set("n", "<leader>\\", function()
			ToggleTransparency(normal)
		end)
		ToggleTransparency(normal)
	end,
})

-- autoformat
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
		if next(clients) ~= nil then
			vim.lsp.buf.format({ async = false })
		end
	end,
})
