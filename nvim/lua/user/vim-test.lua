vim["test#strategy"] = "neovim"
vim["test#neovim#term_position"] = "vert botright 50"

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>rs", ":TestNearest<CR>", opts)
keymap("n", "<leader>rt", ":TestFile<CR>", opts)
keymap("n", "<leader>ra", ":TestSuite<CR>", opts)
keymap("n", "<leader>rl", ":TestLast<CR>", opts)
keymap("n", "<leader>rg", ":TestVisit<CR>", opts)
keymap("n", "<leader>rf", ":TestSuite --only-failures<CR>", opts)
