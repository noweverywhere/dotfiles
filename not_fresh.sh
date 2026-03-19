set -e

DIR_OF_THIS_FILE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DOTFILES_DIR=$DIR_OF_THIS_FILE

pushd $DOTFILES_DIR > /dev/null

cp gitconfig ~/.gitconfig
cp tmux.conf ~/.tmux.conf

# Install bin scripts
mkdir -p ~/bin
for script in "$DOTFILES_DIR/bin/"*; do
    ln -sf "$script" ~/bin/
done

cat <<-VIM_CONFIG > ~/.vimrc
source $DOTFILES_DIR/nvim/init.vim
VIM_CONFIG

cat <<-BASH_CONFIG > ~/.bash_profile
source $DOTFILES_DIR/shell/shellrc
source $DOTFILES_DIR/shell/bashrc
source $DOTFILES_DIR/shell/aliases.sh
source $DOTFILES_DIR/shell/shell_help.sh
BASH_CONFIG

cat <<-BASH_CONFIG > ~/.zshrc
source $DOTFILES_DIR/shell/shellrc
source $DOTFILES_DIR/shell/zshrc
source $DOTFILES_DIR/shell/aliases.sh
source $DOTFILES_DIR/shell/shell_help.sh
BASH_CONFIG

echo "alias dotfiles='~/code/personal/dotfiles/not_fresh.sh && source ~/.bash_profile'" >> ~/.bash_profile

popd > /dev/null
echo "⭐️"
