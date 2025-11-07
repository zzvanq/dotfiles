vim.keymap.set("n", "*", ':execute "normal! *N"<cr>')
vim.keymap.set("n", "#", ':execute "normal! #n"<cr>')
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
vim.keymap.set("n", "<C-p>", ":cprevious<CR>")
vim.keymap.set("n", "<C-s>", ":cclose<CR>")
vim.keymap.set("n", "<F5>", ":SupermavenToggle<CR>")
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":update<CR>", { silent = true })

local last_buf = nil
vim.keymap.set("n", "<leader>e", function()
  local ft = vim.bo.filetype
  if ft == "netrw" then
    vim.cmd("bd")
    if last_buf and vim.api.nvim_buf_is_valid(last_buf) then
      vim.api.nvim_set_current_buf(last_buf)
    end
    last_buf = nil
  else
    last_buf = vim.api.nvim_get_current_buf()
    vim.cmd("Explore")
  end
end, { silent = true, desc = "Toggle explore" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Bufferline
vim.keymap.set("n", "<leader>bb", ":BufferLinePick<CR>", { silent = true })
vim.keymap.set("n", "<leader>be", ":BufferLinePickClose<CR>", { silent = true })
vim.keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", { silent = true })
vim.keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", { silent = true })
vim.keymap.set("n", "<leader>bc", ":BufferLineCloseOthers<CR>", { silent = true })
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true })

-- Git
vim.keymap.set("n", "<leader>gg", ":Gitsigns preview_hunk_inline<CR>", { silent = true })
vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { silent = true })
vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<CR>", { silent = true })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>dn", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>dp", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
