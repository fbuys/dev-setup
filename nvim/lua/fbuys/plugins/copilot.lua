return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      mappings = {
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      -- Toggle Copilot Chat
      vim.keymap.set("n", "<leader>cct", function()
        chat.toggle()
      end, { desc = "Toggle Copilot Chat" })

      -- Trigger Copilot Chat Commit
      vim.keymap.set("n", "<leader>ccc", function()
        chat.commit()
      end, { desc = "Commit Copilot Chat" })

      -- Trigger Copilot Chat Explain
      vim.keymap.set("v", "<leader>cce", function()
        chat.explain()
      end, { desc = "Explain Copilot Chat" })
    end,
  }
}
