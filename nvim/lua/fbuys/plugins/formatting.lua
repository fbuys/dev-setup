return { -- async fast minimalist plugin make format easy in neovim
    'nvimdev/guard.nvim',
    dependencies = {
        { "nvimdev/guard-collection" }, -- required by nvimdev/guard.nvim
    },
    config = function()
        local ft = require('guard.filetype')

        ft('ruby'):fmt('rubocop'):lint('rubocop')
        ft('javascript'):fmt('prettier'):lint('eslint')
        ft('html, json'):fmt('prettier')
        ft('lua'):fmt('lsp'):append('stylua')

        -- call setup LAST
        require('guard').setup({
            -- the only options for the setup function
            fmt_on_save = false,
            -- Use lsp if no formatter was defined for this filetype
            lsp_as_default_formatter = false,
        })

        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>GuardFmt<CR>", opts)
        vim.api.nvim_set_keymap("v", "<leader>ff", "<cmd>GuardFmt<CR>", opts)
    end,
}


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
