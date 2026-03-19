-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- set nu rnu
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])


-- vim.opt.wrap = false

-- -- set a rule at 80 and 90 chars
-- vim.opt.colorcolumn = "80,120"

-- -- highlight indentation levels with different bg colors
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "▸ ", trail = "·", extends = ">", precedes = "<", nbsp = "␣" }
-- -- highlight trailing whitespace characters with red
-- vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
-- vim.cmd([[match ExtraWhitespace /\s\+$/]])
-- -- hi IndentGuidesOdd  ctermbg=236
-- -- hi IndentGuidesEven ctermbg=235
-- vim.cmd([[highlight IndentGuidesOdd  ctermbg=236]])
-- vim.cmd([[highlight IndentGuidesEven ctermbg=235]])

-- -- navigate splits with <C-hjkl>
-- vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- nmap <Tab> gt
-- nmap <S-Tab> gT
-- vim.api.nvim_set_keymap("n", "<Tab>", "gt", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-Tab>", "gT", { noremap = true, silent = true })

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false, auto_update = false },
  change_detection = {
    enabled = false,
    notify = false
  },
})

vim.opt.mouse = ""
