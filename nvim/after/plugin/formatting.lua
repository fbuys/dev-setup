-- I don't want autoformating for now
-- it slows my editor down.
-- require("lsp-format").setup {}
--
-- local on_attach = function(client)
--     require("lsp-format").on_attach(client)
--
--     -- ... custom code ...
-- end
--
-- -- Servers to format
-- require("lspconfig").lua_ls.setup { on_attach = on_attach }
-- require("lspconfig").ruby_ls.setup { on_attach = on_attach }
--
--
-- -- Keymaps
-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<leader>ff", ":Format<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>ft", ":FormatToggle<CR>", opts)
