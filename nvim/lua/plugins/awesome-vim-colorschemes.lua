return {
  "rafi/awesome-vim-colorschemes",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    vim.cmd.colorscheme("onehalfdark")
    -- hi Comment   cterm=italic ctermfg=Black gui=italic guibg=black
    vim.api.nvim_set_hl(0, 'Comment', { fg = '#000000', bg = '#5a6471' })

    -- make the line number of the current line a different color
    -- vim.cmd([[highlight CursorLineNr ctermfg=0 guifg=0]])

  end,
}
