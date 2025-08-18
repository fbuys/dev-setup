math.randomseed(os.time() + tonumber(tostring(os.clock()):reverse()))
local random = math.random
local function generate_uuid()
  local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function (c)
    local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
    return string.format('%x', v)
  end)
end

vim.api.nvim_create_user_command("GardenNewNote", function()
  local uuid = generate_uuid()
  local date = os.date("%Y-%m-%d")

  local frontmatter = {
    "---",
    "title: ",
    "uuid: " .. uuid,
    "date: " .. date,
    "---",
  }

  vim.api.nvim_put(frontmatter, 'l', true, true)
end, {})

vim.keymap.set("n", "<leader>gn", ":GardenNewNote<CR>", { noremap = true, silent = true, desc = "Create a new Garden note with UUID" })
