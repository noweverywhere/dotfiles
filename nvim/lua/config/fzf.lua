require("fzf-lua").setup({
  -- while in live_grep prompt: with default settings (profile)
  -- - ^g allows you to grep the paths of the current matches 
  -- - alt-a selects all, alt-q puts them in quickfix list
  --
  -- in either ^s opens a new split and ^v a new vsplit ^t a new tab

  vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true }),
  vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true }),

  vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true }),

  winopts = {fullscreen = true}
})
