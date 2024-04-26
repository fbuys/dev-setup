-- Fuzzy Finder (files, lsp, etc)
return {
  { 'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ["<C-f>"] =actions.send_selected_to_qflist + actions.open_qflist, 
          },
          n = {
            ["<C-f>"] =actions.send_selected_to_qflist + actions.open_qflist, 
          },
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer]' })

    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Ctrl-P search git files only' })
    vim.keymap.set('n', '<leader>ss', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end, { desc = '[S]earch input [S]tring' })

    -- [LSP SETTINGS]
    vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
  end
  },
  { -- to significantly improve telescope sorting performance
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
}
