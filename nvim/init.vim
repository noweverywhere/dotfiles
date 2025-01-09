" ------------------------------
" Set leader to space
map <Space> <Leader>
let maplocalleader = ","
colorscheme slate " overriden in plugins,
                  " slate is a decent 'dark' theme, alteratives are habamax, retrobox, sorbet
                  " best 'light' defaults are shine, zellner

" Load plugins once leader has been set
if has('nvim')
  " Plugins
  lua require('init')
endif

" Leader Mappings Section
" ------------------------------

" clear search highlights
nnoremap <Leader>\ :nohlsearch<CR>

" Moves to the next/previous item in the quickfix list
nnoremap <Leader>j :cnext<CR>
nnoremap <Leader>k :cprev<CR>

" close the current buffer
nnoremap <Leader>bd :bd<CR>

" Search and replace
nnoremap <Leader>' :s/"/'/<CR>:nohlsearch<CR>
nnoremap <Leader>" :s/'/"/<CR>:nohlsearch<CR>

" resume last visual selection
nnoremap <Leader>v gv

" write vim session to file
nnoremap <Leader>sw :mksession! ~/.vim_session<CR>
nnoremap <Leader>sl :source ~/.vim_session<CR>

" split pane horizontally
nnoremap <Leader>ss :sp<CR>
nnoremap <Leader>sv :vsp<CR>

" open current split as a new tab without removing it from the current tab
nnoremap <Leader>st :tab split<CR>
" open current buffer in a new tab and remove it from the current tab
nnoremap <Leader>stt <C-w>T

" remove trailing whitespace
nnoremap <Leader>rw :%s/\s\+$//e<CR>

" yanks to clipboard
nnoremap <Leader>y "+y
" yanks the entire buffer to clipboard
nnoremap <Leader>by gg"+yG
" replaces the entire buffer contents with the clipboard content
nnoremap <Leader>bp :%d<Bar>put +<CR>:1d<CR>

"copies file path to clipboard
nnoremap <Leader>fp :let @+ = expand('%')<CR>

"pastes from clipboard
nnoremap <Leader>pp "+p
nnoremap <Leader>pP "+P
"
" reloads the buffer
nnoremap <Leader>E :e!<CR>

" replace entire buffer contents with clipboard
" command to replace entire buffer with clipboard: :%d|"+p
" Define the function
function! ReplaceBufferWithClipboard()
  execute 'normal! ggVGd'
  execute 'normal! "+p'
endfunction
" Map the function to <leader>pb
nnoremap <leader>pb :call ReplaceBufferWithClipboard()<CR>

function! MoveBuffer()
  let l:current_filename = expand('%')
  let l:filename = input('Move buffer to: '.l:current_filename)
  if l:filename != ''
    execute 'saveas ' . l:filename
    execute 'silent! !rm ' . l:current_filename
    execute 'edit ' . l:filename
  endif
endfunction
nnoremap <Leader>mv :call MoveBuffer()<CR>

" Display Section
" ------------------------------
" the best choice of the default color schemes is set before the plugins are
" loaded. Then the externally loaded theme is set in the plugins section
syntax enable       " Syntax highlighting (for vim this has to come before other highlighting settings)

set scrolloff=3 " Keep 3 lines above/below the cursor when scrolling

set ruler
set colorcolumn=80,100,120 " show two rulers

set number
set relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
set cursorline " needed to get the current line number highlight to work
set cursorlineopt=number
highlight CursorLineNr ctermfg=white

set laststatus=2 " Always show status line - nvim default
set showcmd      " Show command in bottom bar - nvim default

set foldmethod=syntax
"set foldlevelstart=1
hi Folded ctermbg=7
hi FoldColumn ctermbg=7
hi Folded ctermfg=0
"hi NonText ctermfg=241 guifg=#666666


" Search Section
" ------------------------------
set ignorecase " Case insensitive search
set incsearch  " Makes search act like search in modern browsers -- is a default in nvim
set hlsearch   " Highlight search results -- is a default in nvim
set gdefault   " Make substitute global by default
" Always highlight search matches in green
highlight Search ctermfg=16 ctermbg=46 guifg=#000000 guibg=#60fa68
highlight IncSearch ctermfg=16 ctermbg=46 guifg=#000000 guibg=#d2f860 gui=underline cterm=underline guisp=Black

" Whitespace Section
" ------------------------------
" (might be changed with file type)
set nowrap                    " Do not wrap lines
set expandtab                 " Use spaces instead of tabs
set smarttab
set softtabstop=2             " 1 tab is 2 spaces
set shiftwidth=2
set tabstop=2
set autoindent " enabled in nvim by default
set smartindent

set list " show tabs and trailing spaces
set listchars=tab:▸\ ,trail:·
hi TrailingWhitespace ctermbg=red guibg=red
" call on every file save
function! HighlightWhiteSpace()
  call matchadd("TrailingWhitespace", '\v\s+$')
endfunction
autocmd BufWritePre * call HighlightWhiteSpace()

" Command Mode Section
" ------------------------------
set wildmenu " Command-line completion - nvim default
set wildchar=<Tab>

set wildmode=longest:full,full " Command-line completion - nvim default
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.swn,*.zip

" in command mode map W to save because I often type it instead of w
cnoremap W w

com! -nargs=1 Tabe tabe <args> " :Tabe to open a new tab

" Moving Between Buffers Section
" ------------------------------

" Navigate splits with Ctrl + <direction keys>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

"key nnoremapping for tab navigation
nnoremap <Tab> gt
nnoremap <S-Tab> gT

set splitbelow
set splitright

" Misc Section
" ------------------------------

" Persistent undo
set undofile                " Save undo's after file closes
if has('nvim')
  set undodir=$HOME/.config/nvim/undo " Where to save histories
else
  set undodir=$HOME/.vim/undo " Where to save histories
endif
set undolevels=1000         " How many undos
set undoreload=10000        " Number of lines to save

set history=10000 " Is default in nvim


set mouse=vh "mouse works in visual mode and viewing help files

" Enable spelling for git commit messages, markdown, and text files and markup
" that probably contain normal copy
autocmd FileType gitcommit setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.erb setlocal spell
autocmd BufRead,BufNewFile *.html setlocal spell
