set -e

pushd ~/.dotfiles > /dev/null

cp gitconfig ~/.gitconfig
cp tmux.conf ~/.tmux.conf

cat <<-VIM_CONFIG > ~/.vimrc
source ~/.dotfiles/vim/plug-begin.vim
source ~/.dotfiles/vim/plugins/command-t.vim
source ~/.dotfiles/vim/plugins/grep.vim
source ~/.dotfiles/vim/syntax.vim
source ~/.dotfiles/vim/plugins/ale.vim
source ~/.dotfiles/vim/plugins/gitgutter.vim
source ~/.dotfiles/vim/colorscheme.vim
source ~/.dotfiles/vim/plug-end.vim
source ~/.dotfiles/vim/vimrc
VIM_CONFIG

cat <<-BASH_CONFIG > ~/.bash_profile
source ~/.dotfiles/shell/bashrc
source ~/.dotfiles/shell/aliases.sh
source ~/.dotfiles/shell/bash_help.sh
source ~/.dotfiles/shell/start_into_tmux
BASH_CONFIG

echo "alias dotfiles='~/.dotfiles/not_fresh.sh && source ~/.bash_profile'" >> ~/.bash_profile

popd > /dev/null
echo "⭐️"
