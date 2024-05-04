return {
  {
    -- help you setup Neovim's LSP client
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },           -- Quickstart configs for Nvim LSP
      { 'williamboman/mason-lspconfig.nvim' }, -- makes it easier to use lspconfig
      {                                      -- Easily install and manage LSP servers, DAP servers, linters, and formatters
        'williamboman/mason.nvim',
        init = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'j-hui/fidget.nvim' }, -- Notifications and LSP progress messages in right corner
      { 'folke/neodev.nvim' }, -- Additional lua configuration, makes nvim stuff amazing
    },

    config = function()
      -- Turn on lsp status information
      require('fidget').setup()

      -- Learn to configure LSP servers, see :help lsp-zero-api-showcase
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        ensure_installed = { 'tsserver', 'ruby_lsp' },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        },
      })
    end,
  },
}

-- local lsp = require("lsp-zero").preset({})
--
-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({ buffer = bufnr })
--
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = "LSP: " .. desc
--     end
--
--     vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
--   nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
--   nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
--   nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
--   nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
--
--   -- See `:help K` for why this keymap
--   nmap("K", vim.lsp.buf.hover, "Hover Documentation")
--   nmap("<∂>", vim.lsp.buf.signature_help, "Signature Documentation") -- Alt+d = ∂
--
--   -- Lesser used LSP functionality
--   nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--   nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
--   nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
--   nmap("<leader>wl", function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_fonders()))
--   end, "[W]orkspace [L]ist Folders")
-- end)
--
-- lsp.set_sign_icons({
--   error = '✘',
--   warn = '▲',
--   hint = '⚑',
--   info = '»'
-- })
--
-- -- make sure this servers are installed
-- -- see :help lsp-zero.ensure_installed()
-- lsp.ensure_installed({
--   "elixirls",
--   "lua_ls",
--   "pylsp", -- Add config so pylsp does not auto add flake8
--   "ruby_ls",
--   "gopls",
-- })
--
-- -- Setup lua_ls specifically for Neovim
-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
--
--
-- lsp.setup()

-- lsp.skip_server_setup({ 'elixirls' })

-- require("elixir").setup({
--   credo = {enable = true},
--   elixirls = {enable = true},
-- })

-- Enable logging
-- vim.lsp.set_log_level("debug")

--[[
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don"t have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end


  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  --   python ={
  --     host_python = "~/.venv/nvim/bin/",
  --     default_venv_name = ".venv" -- For local venv
  --   },
  -- },
  pylsp = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  -- ruby_ls ={},
  solargraph = {},
  elixirls = {},
  gopls = {},
}

lsp.configure("solargraph", {
  force_setup = true
})


-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

lsp.setup()
vim.api.nvim_set_keymap("n", "<leader>f", "::LspZeroFormat<cr> ::NullFormat<cr>", { noremap = true, silent = true }) -- Trigger auto format
-- vim.api.nvim_set_keymap("n", "<leader>f", "::NullFormat<cr>", { noremap = true, silent = true })    -- Trigger auto format
--]]
