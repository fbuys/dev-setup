-- Define a command to run async formatting
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

return { -- formatter plugin for Neovim
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- load before writing the whole buffer to a file.
  cmd = { "ConformInfo" }, -- load on command
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    -- Define your formatters
    -- Conform will run multiple (a list of) formatters sequentially
    -- Use a sub-list to run only the first available formatter
    formatters_by_ft = {
      -- lua = { "stylua" },
      -- javascript = { "prettierd", "prettier", "standardjs", stop_after_first = true },
      javascript = { "prettier", stop_after_first = true },
      ruby = { "rubocop" },
      eruby = { "erb_formatter" },
      ["*"] = { "codespell" },
      -- python = { "isort", "black" }, -- list exec
    },
    -- Set up format-on-save
    -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
    -- Customize formatters
    formatters = {
      erb_formatter = {
        command = "bundle",
        args = {
          "exec",
          "erb-format",
          "$FILENAME",
        },
      },
      rubocop = {
        command = "bundle",
        args = {
          "exec",
          "rubocop",
          "--server",
          "-a",
          "-f",
          "quiet",
          "--stderr",
          "--stdin",
          "$FILENAME",
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}

-- return { -- async fast minimalist plugin make format easy in neovim
--     'nvimdev/guard.nvim',
--     dependencies = {
--         { "nvimdev/guard-collection" }, -- required by nvimdev/guard.nvim
--     },
--     config = function()
--         local ft = require('guard.filetype')
--
--         ft('ruby'):fmt('rubocop'):lint('rubocop')
--         ft('javascript'):fmt('prettier'):lint('eslint')
--         ft('html, json'):fmt('prettier')
--         ft('lua'):fmt('lsp'):append('stylua')
--         ft('markdown'):fmt('prettier')
--
--         -- call setup LAST
--         require('guard').setup({
--             -- the only options for the setup function
--             fmt_on_save = false,
--             -- Use lsp if no formatter was defined for this filetype
--             lsp_as_default_formatter = false,
--         })
--
--         local opts = { noremap = true, silent = true }
--         vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>GuardFmt<CR>", opts)
--         vim.api.nvim_set_keymap("v", "<leader>ff", "<cmd>GuardFmt<CR>", opts)
--     end,
-- }
--

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
