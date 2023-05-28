require("lsp-format").setup {}

local on_attach = function(client)
    require("lsp-format").on_attach(client)

    -- ... custom code ...
end
require("lspconfig").ruby_ls.setup { on_attach = on_attach }
