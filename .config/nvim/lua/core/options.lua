-- options
vim.cmd.colorscheme("habamax")
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"
vim.opt.grepprg = "grep -Rn --exclude-dir=\".git\" $* ."

-- autoformat
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- dap-go
local dap = require("dap")
dap.configurations.go = {
  {
    type = "go",
    name = "Attach Golang",
    mode = "remote",
    request = "attach",
  },
}
