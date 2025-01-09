
-- highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
-- highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
vim.cmd([[highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline]])
vim.cmd([[highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline]])

-- let g:qs_max_chars=80
vim.g.qs_max_chars = 200

-- disable on certain filetypes - not able to get this to work right now
-- let g:qs_filetypes = ['fugitive', 'fugitiveblame', 'fugitivediff', 'fugitivediffsplit', 'fugitivediffthis', 'fugitivestatus', 'fugitivestatussplit', 'fugitivetag', 'fugitivetagpreview', 'fugitivetagsplit', 'fugitivewindow']
vim.cmd('let g:qs_buftype_blacklist = ["fugitive", "fugitiveblame", "fugitivediff", "fugitivediffsplit", "fugitivediffthis", "fugitivestatus", "fugitivestatussplit", "fugitivetag", "fugitivetagpreview", "fugitivetagsplit", "fugitivewindow"]')

