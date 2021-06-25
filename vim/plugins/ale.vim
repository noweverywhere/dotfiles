Plug 'w0rp/ale'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

map <Leader>l :ALEFix eslint<CR>
let b:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
