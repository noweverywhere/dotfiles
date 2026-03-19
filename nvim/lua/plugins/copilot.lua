return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
    -- config = function()
    --   require("copilot").setup({
    --   --   enabled = true,
    --   --   filetypes = {
    --   --     yaml = true,
    --   --     help = false,
    --   --     gitcommit = false,
    --   --     gitrebase = false,
    --   --     hgcommit = false,
    --   --     svn = false,
    --   --     cvs = false,
    --   --   },
    --   })
    -- end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      mappings = {
        reset = {
          normal = '<C-r>', -- default was <C-l>, but I use that to navigate splits
          insert = '<C-r>',
        }
      },
    },

    keys = {
      -- in visual mode leader cc will open copliot chat
      { '<leader>cc', '<cmd>CopilotChat<CR>', mode = {'v', 'n'}, desc = 'Open Copilot Chat' },
      { '<leader>cC', '<cmd>CopilotChatReset<CR>|<cmd>CopilotChatClose<CR>', mode = {'v', 'n'}, desc = 'Close Copilot Chat' },
      { '<leader>cd', '<cmd>CopilotChatReset<CR>', mode = {'v', 'n'}, desc = 'Reset Copilot Chat' },
      { '<leader>cv', '<cmd>CopilotChatReset<CR>|<cmd>CopilotChat<CR>', mode = {'v', 'n'}, desc = 'Reset Copilot Chat and Notify' },
      { '<leader>C', '<cmd>Copilot<CR>', mode = {'v', 'n'}, desc = 'Invoke Copilot Chat' },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
