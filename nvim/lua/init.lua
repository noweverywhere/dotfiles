require('plugins.lazy-nvim')
require('config.gitsigns')
require('config.fzf')
require('config.quick-scope')
require('config.tree-sitter')
require('config.coc')
require('config.copilot')
require('config.indent-blankline')
require('config.leap')
local function open_fugitive_if_git_repo()
  if vim.fn.argc() ~= 0 then
    return
  end

  local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error ~= 0 then
    return
  end

  if vim.fn.exists(':G') ~= 2 then
    print("vim-fugitive is not loaded")
    return
  end

  -- Defer the command to ensure Fugitive is loaded
  vim.defer_fn(function()
    vim.cmd('G')
    vim.cmd('wincmd o')  -- Close other windows in the tab
  end, 100)
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    open_fugitive_if_git_repo()
    -- Add other stuff here
  end,
})


-- vim.lsp.config['solargraph'] = {
--   -- Command and arguments to start the server.
--   cmd = { 'solargraph', 'stdio' },
--   -- Filetypes to automatically attach to.
--   filetypes = { 'ruby', 'eruby' },
--   root_markers = { 'Gemfile' },
--   on_attach = function(client, bufnr)
--     print('Solargraph LSP attached to buffer: ' .. bufnr)
--   end,
-- }


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    -- -- if client:supports_method('textDocument/completion') then
    -- --   local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- --   -- client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm.", "")
    -- --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    -- -- end
    -- -- -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    -- if client:supports_method('textDocument/completion') then
    --   -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --   -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    --   -- client.server_capabilities.completionProvider.triggerCharacters = chars
    --   vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    -- end
  end,
})

-- vim.lsp.enable('solargraph')

vim.api.nvim_create_user_command('LspClientsToBuffer', function()
  local clients = vim.lsp.get_active_clients()
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new scratch buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(vim.inspect(clients), '\n'))
  vim.api.nvim_set_current_buf(buf) -- Open the buffer in the current window
end, {})


local plugin_states = {
  lualine = true,
  ale = true,
}

local function toggle_plugins()
  -- Toggle Lualine
  if plugin_states.lualine then
    require('lualine').hide()
    plugin_states.lualine = false
  else
    require('lualine').hide({unhide=true})
    plugin_states.lualine = true
  end

  -- Toggle ALE
  if plugin_states.ale then
    vim.cmd('ALEDisable')
    plugin_states.ale = false
  else
    vim.cmd('ALEEnable')
    plugin_states.ale = true
  end
end

vim.keymap.set('n', '<leader>tp', toggle_plugins, {desc = "Toggle Lualine and ALE"})

vim.keymap.set('n', '<C-i>', '<C-i>', { desc = 'Jump forward in jumplist' })


local shada_dir = vim.fn.stdpath('data') .. '/shada_projects/'

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  callback = function()
    -- Get the current working directory
    local cwd = vim.fn.getcwd()

    -- Create a sanitized, unique name for the shada file
    -- Using a hash is safer, but a simpler substitution often works for common paths.
    -- This example is simplified; consider a dedicated plugin for production use.
    local safe_cwd = cwd:gsub('[^%w%d%-_]', '_')
    local shada_file = shada_dir .. safe_cwd .. '.shada'

    -- Ensure the project-specific shada directory exists
    vim.fn.mkdir(shada_dir, 'p')

    -- Set the shada file for the current Neovim instance
    vim.opt.shadafile = shada_file

    if vim.fn.filereadable(shada_file) == 1 then
      -- Load previous state only if the file exists
      vim.cmd('rshada')
    end

    -- Optional: You may also want to ensure the session is saved to this directory
    -- if you are using sessions.
  end,
  -- Ensure it runs late enough to override any default settings
  group = vim.api.nvim_create_augroup('ProjectShada', { clear = true }),
})

vim.keymap.set('n', '<leader>tr', function()
  local dir = '/test_reports/'
  local files = vim.fn.glob(dir .. '*.log', false, true)
  if #files == 0 then
    vim.notify('No test report files found.', vim.log.levels.WARN)
    return
  end
  table.sort(files)
  local latest = files[#files]
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == vim.fn.fnamemodify(latest, ':p') then
      vim.api.nvim_set_current_buf(buf)
      vim.cmd('normal! G')
      return
    end
  end
  vim.cmd('edit ' .. latest)
  vim.cmd('normal! G')
end, { desc = 'Open most recent test report and jump to bottom' })

-- Re-map 'gd' in normal mode to use ctags for 'Go to Definition'.
vim.keymap.set('n', 'gd', function()
  -- The 'tag' command is the core ctags jump functionality.
  -- vim.fn.expand('<cword>') gets the word under the cursor.
  vim.cmd('tag ' .. vim.fn.expand('<cword>'))
end, {
  noremap = true,
  silent = true,
  desc = 'Go to Definition (ctags)'
})
