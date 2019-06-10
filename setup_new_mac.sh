set -e

which -s brew
if [[ $? != 0 ]] ; then
  echo "installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "install brew dependencies"
cat <<BREW_DEPS | xargs brew install
git
direnv
vim
rbenv
tree
tmux
jq
nvm
git-flow
fzf
bat
bash-completion
nnn
neovim
postgresql
puma/puma/puma-dev
BREW_DEPS
# Install puma-dev as a launchd agent

pip3 install diff-highlight

SSH_DIR="/Users/$USER/.ssh/"
if [ ! -d $SSH_DIR ]; then
  echo "Setup SSH Keys"
  mkdir ~/.ssh
  pushd ~/.ssh
  ssh-keygen -t rsa -b 4096 -C "marinus@noweveryhere.ca"
  popd

  echo -n "Hit enter to automatically copy ssh key into clipboard and to paste it into github"
  pbcopy < ~/.ssh/id_rsa.pub
  open -a "Google Chrome" https://github.com/settings/keys
else
  echo "~/.ssh already exists so we assume the keys are already set up"
fi


DOTFILES_DIR="/Users/$USER/code/personal/dotfiles/"
if [ ! -d $DOTFILES_DIR ]; then
  echo "About to clone dotfiles from git"
  mkdir -p ~/code/personal
  pushd ~/code/personal
  git clone git@github.com:noweverywhere/dotfiles.git
  popd
else
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  if [[ "$BRANCH" != "master" ]]; then
    echo "make sure dotfiles at $DOTFILES_DIR are on master branch";
    exit 1;
  fi
  echo "updating dotfiles"
  pushd $DOTFILES_DIR
  git pull
fi
$DOTFILES_DIR/not_fresh.sh

echo "Put screenshots in ~/screenshots/ instead of ~/Desktop to  keep things tidy"
mkdir -p ~/screenshots
defaults write com.apple.screencapture location ~/screenshots

echo "setup vim config"
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo ":PlugInstall" | pbcopy
echo "when vim opens just hit colon then paste (or type in ':PlugInstall') to install plugins (hit enter to continue)"
read FOO
vim
