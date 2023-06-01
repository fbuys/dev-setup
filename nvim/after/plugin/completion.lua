-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require('lspkind')
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',       -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- go to next placeholder in the snippet
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- go to previous placeholder in the snippet
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = 'tags' },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "spell" },
  },
}

-- add rails snippets to ruby
luasnip.filetype_extend("ruby", { "rails" })
luasnip.filetype_extend("python", { "python" })

-- Own snippets
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

-- Markdown snippets
luasnip.add_snippets("markdown", {
  -- luasnip.parser.parse_snippet("timeentry", "@$1\n============\n$2\n[$3-$4](#:##)")
  -- trigger is `timeentry`, expands into time entry with project, notes, start time, stop time and duration
  s("timeentry", {
    -- prompt for project
    t("@"), i(1),
    -- linebreak
    t({ "", "============", "" }),
    -- notes placeholder
    i(2),
    -- linebreak then [<start>-<stop>](<duration>)
    t({ "", "[" }), i(3), t("-"), i(4), t("]("), i(5), t(")"),
  })
})


