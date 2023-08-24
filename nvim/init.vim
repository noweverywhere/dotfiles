set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

colorscheme xcodedark

source /Users/marinus/code/personal/dotfiles/vim/plug-begin.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/marks.vim
source /Users/marinus/code/personal/dotfiles/vim/colorscheme.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/grep.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/formatter.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/fugitive.vim
source /Users/marinus/code/personal/dotfiles/vim/syntax.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/ale.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/vim-rails.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/vim-test.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/gitgutter.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/indent-guides.vim
source /Users/marinus/code/personal/dotfiles/vim/fzf.vim
source /Users/marinus/code/personal/dotfiles/vim/plugins/surround.vim
source /Users/marinus/code/personal/dotfiles/vim/plug-end.vim
source /Users/marinus/code/personal/dotfiles/vim/vimrc


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


lua <<LUA
require'marks'.setup {
  default_mappings = true,
  signs = true,
  mappings = {},
  builtin_marks = { ".", "<", ">", "^", "0", '"', "]", "[" },
}
LUA
