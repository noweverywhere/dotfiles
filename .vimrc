set ignorecase " Case insensitive search
set incsearch  " Makes search act like search in modern browsers
set hlsearch   " Highlight search results
set backspace=2

" Whitespace
set listchars=tab:▸\ ,trail:· " Show tabs, trailing whitespace and end of lines
set nowrap                    " Do not wrap lines
set expandtab                 " Use spaces instead of tabs
set smarttab                  " Be smart when using tabs ;-)
set softtabstop=2             " 1 tab is 2 spaces
set shiftwidth=2
set tabstop=2
set foldmethod=indent         " Fold based on indentation.
set foldlevelstart=99         " Expand all folds by default.
set backspace=2

" Disable backup. No swap files.
set nobackup
set nowb
set noswapfile

" Window
syntax enable       " Syntax highlighting
set hidden          " Allow hiding buffers with unsaved changes
set number          " Show line numbers
set ruler           " Show cursor position
set spelllang=en_au " Australian English

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " Where to save histories
set undolevels=1000         " How many undos
set undoreload=10000        " Number of lines to save

 "Always show current position
set ruler

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Show lin numbers
set number

" Show margin line
set colorcolumn=80,100

" Highlight cursor line
set cursorline

" Set theme
colorscheme termschool

"autocmd FileType js,rb,html,sass,scss autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e
