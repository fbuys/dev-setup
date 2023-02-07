  require('git-conflict').setup()

-- Default keymπ options
local opts = { noremap = true, silent = true }

-- Git conflict keymaps
vim.api.nvim_set_keymap("n", "<leader>co", "<Plug>(git-conflict-ours)", opts)
vim.api.nvim_set_keymap("n", "<leader>ct", "<Plug>(git-conflict-theirs)", opts)
vim.api.nvim_set_keymap("n", "<leader>cb", "<Plug>(git-conflict-both)", opts)
vim.api.nvim_set_keymap("n", "<leader>c0", "<Plug>(git-conflict-none)", opts)
vim.api.nvim_set_keymap("n", "]x", "<Plug>(git-conflict-prev-conflict)", opts)
vim.api.nvim_set_keymap("n", "[x", "<Plug>(git-conflict-next-conflict)", opts)
vim.api.nvim_set_keymap("n", "<leader>gx", "<cmd>GitConflictListQf<cr>", opts)


