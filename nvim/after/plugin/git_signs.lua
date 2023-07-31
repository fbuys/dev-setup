-- Gitsigns
-- See `:help gitsigns.txt`
-- local icons = require("../../lua/fbuys/icons.lua")

require('gitsigns').setup {
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '▎' },
  },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
