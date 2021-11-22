set -e

read -p "Don't foget to install Magnet to snap windows to the edges:
https://itunes.apple.com/au/app/magnet/id441258766?mt=12
(hit enter to continue)"

which -s brew
if [[ $? != 0 ]] ; then
  echo "installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "install brew dependencies"
# it might me nicer to have these deps listed in a seperate file, but the idea
# is to curl this one file and it should take care of everything in one step
# TODO: Look into Homebre-bundle: https://github.com/Homebrew/homebrew-bundle
cat <<BREW_DEPS > Brewfile
brew "git"
brew "direnv"
brew "vim"
brew "rbenv"
brew "tree"
brew "tmux"
brew "jq"
brew "ag"
brew "rg"
brew "nvm"
brew "git-flow"
brew "fzf"
brew "bat"
brew "bash-completion"
brew "wget"
brew "nnn"
brew "neovim"
brew "postgresql"
brew "redis"
brew "awscli"
brew "asimov"
cask "slack"
cask "iterm2"
cask "1password"
cask "tunnelblick"
cask "firefox"
cask "visual-studio-code"
BREW_DEPS
brew bundle
cat <(echo "Don't modify this file directly. Instead edit setup_new_mac.sh") Brewfile > Brewfile.tmp
mv Brewfile{.tmp,}
# Install puma-dev as a launchd agent

pip3 install diff-highlight

# for postgres shell to work with command `psql` you need a db name after $USER
# the below command creates that db.
createdb

read "Will you be using heroku on this machine?(y/n)" USE_HEROKU
if [[ $USE_HEROKU == "y" || $USE_HEROKU == "Y" || $USE_HEROKU == "yes" || $USE_HEROKU == "Yes" ]]
then
  brew tap heroku/brew
  brew install heroku
fi

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

# below repo is to disable bluetooth when computer goes to sleep
# git clone git@github.com:alb12-la/KBOS.git

echo "Put screenshots in ~/screenshots/ instead of ~/Desktop to  keep things tidy"
mkdir -p ~/screenshots
defaults write com.apple.screencapture location ~/screenshots

echo "setup vim config"
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat | vim - <<EOF
" Below are the steps you need to perform to set up vim
" Note lines starting with the following charachters:
" '"' are comments/instructions
" ':' are vim commands
" '!' are shell commands)

:PlugInstall "to install plugins

" Below are the steps to compile command-t when managing plugins with Plug

:ruby puts RUBY_VERSION
"remember ruby version printed above, you will need replace
"ruby_version below with it

!pushd ~/.vim/plugged/Command-T/ruby/command-t/ext/command-t
!rbenv use ruby_version
!ruby extconf.rb
!make
!popd
EOF

echo "you got to the spot after vim"

mkdir ~/code/vendor
git clone git@github.com:alb12-la/KBOS.git ~/code/vendor/kbos
cd ~/code/vendor/kbos/
git checkout b696696
chmod +x install.sh

npm install -g git-checkout-interactive

# files that need to be copied from old computer
# rails apps config/master.key
# .envrc files for different projects
# vpn config files

echo "DONE 🙌"
