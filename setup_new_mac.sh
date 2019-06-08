set -e

which -s brew
if [[ $? != 0 ]] ; then
  echo "installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "brew already installed, updating"
  brew update
fi

echo "install brew dependencies"
brew install git direnv vim rbenv tree tmux jq nvm git-flow fzf bat bash-completion nnn

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


echo "About to clone dotfiles from git"
mkdir -p ~/code/personal
pushd ~/code/personal
git clone git@github.com:noweverywhere/dotfiles.git
~/code/personal/dotfiles/not_fresh.sh
popd
source ~/.bash_profile

echo "setup vim config"
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pbcopy < echo ":PlugInstall"
echo "when vim opens just hit paste to install plugins"
read
vim
