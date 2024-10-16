Plug 'w0rp/ale'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

map <Leader>L :ALEFix eslint<CR>
let b:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop', 'remove_trailing_lines', 'trim_whitespace']
\}

" Set this variable to 1 to fix files when you save them.
" Though I find it counter-productive to have unused variables immediatly
" prefixed with "_" to make them pass the linter, because when I want to refer
" to them later I have to remember the prefix was added
let g:ale_fix_on_save = 0
