-- require("mason-null-ls").setup({
--   automatic_setup = true,
--   ensure_installed = {
--     "black",
--     "credo",
--     "pyproject_flake8",
--     "goimports",
--     "goimports_reviser",
--     "golangci_lint",
--     "mix",
--     "prettier",
--     -- "rubocop",
--     -- "gofumpt",
--     -- "spell",
--     -- "tags",
--   },
-- })
--
-- local null_ls = require('null-ls')

-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(client)
--             -- apply whatever logic you want (in this example, we'll only use null-ls)
--             return client.name == "null-ls"
--         end,
--         bufnr = bufnr,
--     })
-- end

-- if you want to set up formatting on save, you can use this as a callback
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
-- local on_attach = function(client, bufnr)
--   if client.supports_method("textDocument/formatting") then
--     -- require("lsp-format").on_attach(client)
--     local format_cmd = function(input)
--       vim.lsp.buf.format({
--         id = client.id,
--         timeout_ms = 10000, -- has no affect when async is true
--         async = input.bang,
--       })
--     end
--
--     local bufcmd = vim.api.nvim_buf_create_user_command
--     bufcmd(bufnr, 'NullFormat', format_cmd, {
--       bang = true,
--       range = true,
--       desc = 'Format using null-ls'
--     })
--
--     -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--     -- vim.api.nvim_create_autocmd("BufWritePre", {
--     --   group = augroup,
--     --   buffer = bufnr,
--     --   callback = function()
--     --     lsp_formatting(bufnr)
--     --   end,
--     -- })
--   end
-- end

-- null_ls.setup({
--   debug = false,
--   on_attach = on_attach,
--   sources = {
--     -- Formatting
--     null_ls.builtins.formatting.black,
--     null_ls.builtins.formatting.gofumpt,
--     null_ls.builtins.formatting.goimports,
--     null_ls.builtins.formatting.goimports_reviser,
--     ---- Elixir
--     null_ls.builtins.formatting.mix,
--     ---- Prettier
--     null_ls.builtins.formatting.prettier.with({
--       extra_filetypes = { "ruby" }
--     }),
--     -- Diagnostics
--     ---- Elixir
--     null_ls.builtins.diagnostics.credo,
--     ---- Go
--     null_ls.builtins.diagnostics.golangci_lint,
--     ---- Ruby
--     -- null_ls.builtins.diagnostics.rubocop,
--     ---- Python
--     null_ls.builtins.diagnostics.pyproject_flake8,
--     null_ls.builtins.diagnostics.pylint,
--   },
-- })
--
-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<leader>ff", ":NullFormat<CR>", opts)
--

--[[
local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

local conditional = function(fn)
  local utils = require("null-ls.utils").make_conditional_utils()
  return fn(utils)
end

null_ls.setup({
  debug = true,
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
    ---
    -- you can add other stuff here....
    ---
    --
    local format_cmd = function(input)
      vim.lsp.buf.format({
        id = client.id,
        timeout_ms = 10000,
        async = input.bang,
      })
    end

    local bufcmd = vim.api.nvim_buf_create_user_command
    bufcmd(bufnr, 'NullFormat', format_cmd, {
      bang = true,
      range = true,
      desc = 'Format using null-ls'
    })
  end,
  sources = {
    -- Replace these with the tools you have installed
    -- null_ls.builtins.completion.spell,
    -- null_ls.builtins.completion.tags,
    -- null_ls.builtins.diagnostics.rubocop,
    -- null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.prettier.with({
      extra_filetypes = { "ruby" }
    }),
    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.black,
    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and null_ls.builtins.diagnostics.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
          })
          or (null_ls.builtins.diagnostics.rubocop)
    end),
    -- conditional(function(utils)
    --   return utils.root_has_file("Gemfile")
    --       and null_ls.builtins.formatting.rubocop.with({
    --         command = "bundle",
    --         args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
    --       })
    --       or (null_ls.builtins.formatting.rubocop)
    -- end),
    -- GO lang
  }
})

require("mason").setup()
require("mason-null-ls").setup({
  automatic_setup = true,
  ensure_installed = {
    "black",
    "gofumpt",
    "goimports",
    "goimports_reviser",
    "golangci_lint",
    "prettier",
    "rubocop",
    "spell",
    "tags",
  },
})
--]]


