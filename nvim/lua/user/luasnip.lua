local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- For dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  ext_opts = nil,
  -- ext_opts = {
  --   [types.choiceNode] = {
  --     active = {
  --       virt_text = { { " <- Current Choice", "NonTest" } },
  --     },
  --   },
  -- },
}

-- Not sure if need these
-- load the snippets contained in friendly-snippits
require("luasnip.loaders.from_vscode").lazy_load()
ls.filetype_extend("ruby", {"rails"})
ls.filetype_extend("vue", {"vue/html", "vue/javascript", "vue/vue"})

-- Own snippets
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Markdown snippets
ls.add_snippets("markdown", {
  -- ls.parser.parse_snippet("timeentry", "@$1\n============\n$2\n[$3-$4](#:##)")
  -- trigger is `timeentry`, expands into time entry with project, notes, start time, stop time and duration
  s("timeentry", {
    -- prompt for project
    t("@"), i(1, "<project>"),
    -- linebreak
    t({"", "============", ""}),
    -- notes placeholder
    i(2, "<notes...>"),
    -- linebreak then [<start>-<stop>](<duration>)
    t({"", "["}), i(3, "<start>"), t("-"), i(4, "<stop>"), t("]("), i(5, "<duration>"), t(")"),
  })
})

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/user/luasnip.lua<CR>")
