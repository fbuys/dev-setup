return {
  -- A completion plugin for neovim coded in Lua.
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' }, -- nvim-cmp source for neovim's built-in language server client
    { 'f3fora/cmp-spell' }, -- Autocompletion spellsuggest.
    { 'hrsh7th/cmp-buffer' }, -- Autocompletion for buffer words.
    { 'hrsh7th/cmp-nvim-lua' },     -- Autocompletion for neovim Lua API.
    { 'hrsh7th/cmp-path' }, -- Autocompletion for path.
    { 'onsails/lspkind.nvim' }, -- icons next to autocomplete list items
    { 'saadparwaiz1/cmp_luasnip' }, -- Lua specific autocomplete.
    { 'L3MON4D3/LuaSnip' }, -- Snippet Engine for Neovim written in Lua. 
    {
      -- Autocompletion tags sources for nvim-cmp.
      'quangnguyen30192/cmp-nvim-tags',
      -- if you want the sources is available for some file types
      ft = {
        'markdown',
        'ruby',
      }
    },
    { 'rafamadriz/friendly-snippets' }, -- Set of preconfigured snippets for different languages.
  },
  config = function ()
    -- nvim-cmp setup
    local cmp = require 'cmp'
    local lspkind = require('lspkind')
    local luasnip = require 'luasnip'
    require("luasnip/loaders/from_vscode").lazy_load()

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

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
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
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
        -- [<start>-<stop>](<duration>)
        t({ "[" }), i(1), t("-"), i(2), t("]("), i(3), t(") - ", i(4)),
        -- prompt for project
        -- t("# @"), i(1),
        -- linebreak
        -- t({ "", "============", "" }),
        -- t({ "", "============", "" }),
        -- notes placeholder
        -- t({ "" }), i(2),
      })
    })
  end,
}
