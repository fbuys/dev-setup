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
keymap("n", ",,", "<C-^>", opts)                                      -- Alternate buffers
keymap("n", "<C-j>", ":m .+1<CR>", opts)                            -- Move line down
keymap("n", "<C-k>", ":m .-2<CR>", opts)                            -- Move line up
keymap("n", ";w", ":w<CR>", opts)                                   -- Save
keymap("n", ";q", ":q<CR>", opts)                                   -- Quit
keymap("n", ";wq", ":wq<CR>", opts)                                 -- Save and quite
keymap("n", "<space><space>", ":nohlsearch<Bar>:echo<cr>", opts)      -- turn off highlighting


-- Visual --
keymap("v", "<", "<gv", opts)                             -- Stay in indent mode
keymap("v", ">", ">gv", opts)                             -- Stay in indent mode
keymap("v", "p", '"_dP', opts)                            -- Paste without yanking

-- Telescope
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "g*", "<cmd>Telescope grep_string<cr>", opts)

-- open-browser-github
keymap("n", "<leader>go", "<cmd>OpenGithubFile<cr>", opts)
