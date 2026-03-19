return {
  "tpope/vim-fugitive",
  lazy = false,
  cmd = "Git",
  keys = {
    { '<leader>gaa', '<cmd>Git add %<CR>', mode = 'n', desc = 'Git add buffer', silent = false },
    { '<leader>gap', '<cmd>Git add % -p <CR>', mode = 'n', desc = 'Git add buffer', silent = true },
    { '<leader>gre', '<cmd>Git reset %<CR>', mode = 'n', desc = 'Git reset buffer' },
    { '<leader>gco', '<cmd>Git checkout %<CR>', mode = 'n', desc = 'Git checkout buffer' },
    { '<leader>gbr', '<cmd>!Git rev-parse --abbrev-ref HEAD<CR>', mode = 'n', desc = 'Show current branch name' },
    { '<leader>G', '<cmd>tab Git<cr>/^M\\s<cr>:let @/=""<cr>', mode = 'n', desc = 'Open Fugitive as a new tab with git status' },
    { '<leader>gs', '<cmd>Git<CR>', mode = 'n', desc = 'Open Fugitive' },
    { '<leader>gD', '<cmd>Git diff<CR>', mode = 'n', desc = 'Git diff' },
    { '<leader>gd', '<cmd>Git diff %<CR>', mode = 'n', desc = 'Git diff buffer' },
    { '<leader>ge', '<cmd>Gedit<CR>', mode = 'n', desc = 'Git edit' },
    { '<leader>gcm', '<cmd>Git commit<CR>', mode = 'n', desc = 'Git commit' },
    { '<leader>grm', '<cmd>Git rm %<CR>', mode = 'n', desc = 'Git remove current file from working tree and stage its removal' },
    { '<leader>gca', '<cmd>Git commit --amend<CR>', mode = 'n', desc = 'Git amend last commit' },
    { '<leader>gl', '<cmd>Git log -p %<CR>', mode = 'n', desc = 'Git log buffer' },
    { '<leader>gbl', '<cmd>Git blame<CR>', mode = 'n', desc = 'Git blame' },
  },
  config = function ()
    vim.api.nvim_set_keymap('n', '<leader>gt', '', {
      noremap = true,
      silent = true,
      callback = function()
        local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree'):match("true")
        if not is_git_repo then
          print("Not inside a Git repository")
          return
        end

        local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):match("([^%s]+)")
        local ticket_number = branch:match("%d+")
        if ticket_number then
          vim.api.nvim_put({ ticket_number }, 'c', true, true)
        else
          print("No ticket number found in branch name")
        end
      end,
      desc = 'Insert ticket number from branch name'
    })

    vim.api.nvim_set_keymap('n', '<leader>gT', '', {
      noremap = true,
      silent = true,
      callback = function()
        local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):match("([^%s]+)")
        local ticket_number = branch:match("%d+")
        local base_url = vim.fn.getenv('TICKET_BASE_URL')

        if base_url and ticket_number ~= '' then
          local url = base_url .. ticket_number
          vim.fn.system({'open', url})
        else
          print('TICKET_BASE_URL is not set or ticket number is empty')
        end
      end
    })

    local save_session_map = '<leader>sgw'
    local function save_session_with_git_branch(called_from_keymap)
      local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):match("([^%s]+)")
      local data_dir = vim.fn.stdpath('data') .. '/sessions'
      vim.fn.mkdir(data_dir, 'p')
      local session_file = branch .. '.vim'
      session_file = session_file:gsub('[^%w%.%-]', '_')
      vim.cmd('mksession! ' .. data_dir .. '/' .. session_file)

      if called_from_keymap then
        print('Session file saved as ' .. session_file)
      else
        print('Session file saved as ' .. session_file .. '\tThe map for this action is "' .. save_session_map .. '"')
      end
    end

    vim.api.nvim_create_user_command('SSaveWithGitBranch', function () save_session_with_git_branch(false) end, {})
    vim.api.nvim_create_user_command('SessionSaveWithGitBranch', function () save_session_with_git_branch(false) end, {})
    vim.api.nvim_set_keymap('n', save_session_map, 'Write neovim session file with git branch name as file name', {
      noremap = true,
      callback = function()
        save_session_with_git_branch(true)
      end
    })

    local load_session_map = '<leader>sgl'
    local function load_session_with_git_branch()
      local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):match("([^%s]+)")
      local data_dir = vim.fn.stdpath('data') .. '/sessions'
      local session_file = branch .. '.vim'
      session_file = session_file:gsub('[^%w%.%-]', '_')
      local full_path = data_dir .. '/' .. session_file

      if vim.fn.filereadable(full_path) == 1 then
        vim.cmd('source ' .. full_path)
      else
        print('Session file does not exist: ' .. full_path)
      end
    end

    vim.api.nvim_create_user_command('SessionLoadWithGitBranch', function() load_session_with_git_branch(false) end, {})
    vim.api.nvim_create_user_command('SLoadWithGitBranch', function() load_session_with_git_branch(false) end, {})
    vim.api.nvim_set_keymap('n', load_session_map, 'Read neovim session file with git branch name as file name', {
      noremap = true,
      callback = function()
        load_session_with_git_branch(true)
      end
    })
  end
}
