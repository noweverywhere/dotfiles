require("fzf-lua").setup({
  -- while in live_grep prompt: with default settings (profile)
  -- - ^g allows you to grep the paths of the current matches
  -- - alt-a selects all, alt-q puts them in quickfix list
  --
  -- in either ^s opens a new split and ^v a new vsplit ^t a new tab

  vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true }),

  vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<CR>", { noremap = true, silent = true, desc = "Grep for the word under the cursor" }),
  vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", { noremap = true, silent = true, desc = "Resume the last fzf session" }),
  vim.keymap.set("v", "<leader>fg", "<cmd>lua require('fzf-lua').grep_visual()<CR>", { noremap = true, silent = true , desc = "Grep the visual selection" }),

  vim.api.nvim_create_user_command('Keymaps', function()
    require("fzf-lua").keymaps()
  end, {}),

  winopts = {fullscreen = true}
})
