vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_user_command('Config', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
end, { desc = "Open this file" })

require("core.lazy")
require("core.autocmds")
require("core.options")
require("core.keymaps")
