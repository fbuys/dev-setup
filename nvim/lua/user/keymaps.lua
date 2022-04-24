local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "                                     -- Use space as leader
vim.g.maplocalleader = ","                                -- Use , as local leader

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<leader>e", ":Lex 30<cr>", opts)
keymap("n", ",,", "<C-^>", opts)                          -- Alternate buffers
keymap("n", "<C-j>", ":m .+1<CR>==", opts)                -- Move line down
keymap("n", "<C-k>", ":m .-2<CR>==", opts)                -- Move line up
keymap("n", ";w", ":w<CR>==", opts)                       -- Save
keymap("n", ";q", ":q<CR>==", opts)                       -- Quit
keymap("n", ";wq", ":wq<CR>==", opts)                     -- Save and quite

-- Visual --
keymap("v", "<", "<gv", opts)                             -- Stay in indent mode
keymap("v", ">", ">gv", opts)                             -- Stay in indent mode
keymap("v", "p", '"_dP', opts)                            -- Paste without yanking
