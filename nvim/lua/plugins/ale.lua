return {
  'dense-analysis/ale',
  -- keys = {
  -- defining my maps in the config function because doing it here breaks it
  -- },
  config = function()
    -- Configuration goes here.
    local g = vim.g

    g.ale_ruby_rubocop_auto_correct_all = 1

    g.ale_linters = {
      ruby = {'rubocop', 'ruby'},
      lua = {'lua_language_server'},
      javascript = {'eslint'},
    }
    g.ale_fixers = {
      ruby = { 'rubocop' },
      javascript = {'eslint'}
    }
    -- for some reason using the `keys` property breaks loading the plugin
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<leader>af', '<cmd>ALEFix<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ad', '<cmd>ALEDisableBuffer<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>aD', '<cmd>ALEDisable<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ae', '<cmd>ALEEnableBuffer<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>aE', '<cmd>ALEEnable<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>an', '<cmd>ALENext<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>aj', '<cmd>ALENext<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>J', '<cmd>ALENext<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ap', '<cmd>ALEPrevious<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ak', '<cmd>ALEPrevious<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>K', '<cmd>ALEPrevious<CR>', opts)
  end
}
