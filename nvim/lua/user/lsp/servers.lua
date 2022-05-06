-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'sumneko_lua', 'solargraph', 'tsserver', 'volar' }
local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

for _, lsp in pairs(servers) do
  if lsp == "sumneko_lua" then
    opts["settings"] = require("user.lsp.settings.sumneko_lua")
  end

  require('lspconfig')[lsp].setup(opts)
 end
