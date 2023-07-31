set -e

DIR_OF_THIS_FILE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DOTFILES_DIR=$DIR_OF_THIS_FILE

pushd $DOTFILES_DIR > /dev/null

cp gitconfig ~/.gitconfig
cp tmux.conf ~/.tmux.conf

cat <<-VIM_CONFIG > ~/.vimrc
source $DOTFILES_DIR/vim/plug-begin.vim
source $DOTFILES_DIR/vim/plugins/command-t.vim
source $DOTFILES_DIR/vim/plugins/grep.vim
source $DOTFILES_DIR/vim/plugins/formatter.vim
source $DOTFILES_DIR/vim/syntax.vim
source $DOTFILES_DIR/vim/plugins/ale.vim
source $DOTFILES_DIR/vim/plugins/indent-guides.vim
source $DOTFILES_DIR/vim/plugins/signify.vim
source $DOTFILES_DIR/vim/plugins/rails.vim
source $DOTFILES_DIR/vim/colorscheme.vim
source $DOTFILES_DIR/vim/fzf.vim
source $DOTFILES_DIR/vim/plugins/fugitive.vim
source $DOTFILES_DIR/vim/plugins/surround.vim
source $DOTFILES_DIR/vim/plug-end.vim

source $DOTFILES_DIR/vim/vimrc
VIM_CONFIG

cat <<-BASH_CONFIG > ~/.bash_profile
source $DOTFILES_DIR/shell/bashrc
source $DOTFILES_DIR/shell/aliases.sh
source $DOTFILES_DIR/shell/shell_help.sh
BASH_CONFIG


cat <<-Z_CONFIG > ~/.zprofile
# source $DOTFILES_DIR/shell/bashrc
source $DOTFILES_DIR/shell/shellrc
source $DOTFILES_DIR/shell/aliases.sh
source $DOTFILES_DIR/shell/shell_help.sh
Z_CONFIG

echo "alias dotfiles='~/code/personal/dotfiles/not_fresh.sh && source ~/.bash_profile'" >> ~/.bash_profile
echo "alias dotfiles='~/code/personal/dotfiles/not_fresh.sh && source ~/.zprofile'" >> ~/.bash_profile

popd > /dev/null
echo "⭐️"
