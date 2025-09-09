lvim.colorscheme = "solarized-flat"
lvim.builtin.cmp.window.completion = {
  border = "single",
}
lvim.builtin.cmp.window.documentation = {
  border = "single",
}
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.bufferline.options.right_mouse_command = "vert sbuffer %d"
lvim.builtin.lualine.sections.lualine_a = { "mode" }

vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"

lvim.plugins = {
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  {"AndrewRadev/splitjoin.vim"},
  {"fatih/vim-go"},
  { "leoluz/nvim-dap-go", dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<F2>",
          accept_word = "<F3>",
          clear_suggestion = "<F4>",
        },
        -- disable_keymaps = true,
        -- disable_inline_completion = true,
      })
    end,
  },
  { "ishan9299/nvim-solarized-lua"},
}
-- vim.list_extend(lvim.builtin.cmp.sources, {
--   { name = "supermaven" }
-- })

local function vim_enter_callback()
  -- require("nvim-tree.api").tree.open()
  vim.cmd("SupermavenStop")
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = vim_enter_callback })

-- remaps
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
vim.keymap.set("n", "<C-m>", ":cprevious<CR>")
vim.keymap.set("n", "<C-x>", ":cclose<CR>")
vim.keymap.set("n", "<F5>", ":SupermavenToggle<CR>")

-- dap-go
local dap = require('dap')
dap.configurations.go = {
  {
    type = "go",
    name = "Attach Golang",
    mode = "remote",
    request = "attach",
  },
}

-- vim-go
vim.g.go_fmt_command = "goimports"
vim.g.go_list_type = "quickfix"
vim.g.go_auto_type_info = 1
vim.g.go_auto_same_ids = 1

vim.keymap.set("n", "]t", ":TodoTelescope<CR>")
lvim.builtin.which_key.mappings["]"] = {
  name = "Tools",
  t = {"<cmd>TodoTelescope<CR>", "Todos"}
}

lvim.builtin.which_key.mappings["e"] = {":NvimTreeFocus<CR>", "Explorer"}

