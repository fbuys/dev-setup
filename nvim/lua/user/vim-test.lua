vim["test#strategy"] = "neovim"
vim["test#neovim#term_position"] = "vert botright 50"

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", ",rs", ":TestNearest<CR>", opts)
keymap("n", ",rt", ":TestFile<CR>", opts)
keymap("n", ",ra", ":TestSuite<CR>", opts)
keymap("n", ",rl", ":TestLast<CR>", opts)
keymap("n", ",rg", ":TestVisit<CR>", opts)
keymap("n", ",rf", ":TestSuite --only-failures<CR>", opts)
