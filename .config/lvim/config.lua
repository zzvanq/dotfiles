lvim.colorscheme = "slate"
lvim.builtin.cmp.window.completion = {
  border = "none",
}
lvim.builtin.cmp.window.documentation = {
  border = "none",
}
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.bufferline.options.right_mouse_command = "vert sbuffer %d"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.terminal.direction = "vertical"
lvim.builtin.terminal.size = 75
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"

-- remaps
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
vim.keymap.set("n", "<C-m>", ":cprevious<CR>")
vim.keymap.set("n", "<C-x>", ":cclose<CR>")
vim.keymap.set("n", "<F5>", ":SupermavenToggle<CR>")
vim.keymap.set("n", "]t", ":TodoTelescope<CR>")
vim.keymap.set("n", "*", ":execute \"normal! *N\"<cr>")
vim.keymap.set("n", "#", ":execute \"normal! #n\"<cr>")
lvim.builtin.which_key.mappings["]"] = {
  name = "Tools",
  t = {"<cmd>TodoTelescope<CR>", "Todos"}
}

lvim.plugins = {
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  { "AndrewRadev/splitjoin.vim" },
  { "fatih/vim-go" },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    config = function ()
      require('render-markdown').setup({
        completions = { lsp = { enabled = true } },
      })
      require("lvim.lsp.manager").setup("marksman")
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },
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
}

function ToggleTransparency(normal, normalfloat)
  local current_normal = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  if current_normal ~= normal then
    vim.api.nvim_set_hl(0, "Normal", { bg = normal })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = normalfloat })
  else
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
end

local function vim_enter_callback()
  -- require("nvim-tree.api").tree.open()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  local normalfloat = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg

  vim.keymap.set("n", "<leader>\\", function () ToggleTransparency(normal, normalfloat) end)
  ToggleTransparency(normal, normalfloat)
  vim.cmd("SupermavenStop")
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = vim_enter_callback })

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

