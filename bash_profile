export PATH="$PATH:~/bin"
source ~/bin/functions.sh

alias cucumber="bundle exec cucumber"
alias rubocop="bundle exec rubocop"
alias doco="docker-compose"
alias domo="docker-machine"
alias gm="git co master"
alias be="bundle exec"

export redisstart='redis-server /usr/local/etc/redis.conf'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="~/code/plain-utils/bin:$PATH"

ssh-add ~/.ssh/id_rsa

source /Users/marinus.swanepoel/.oh-my-git/prompt.sh
source ~/bin/git-completion.bash

eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"

export NVM_DIR="/Users/marinus.swanepoel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

function git-log() {
  git log -M40 --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(green bold)- %an %C(black bold)%cd (%cr)%Creset' --abbrev-commit --date=short "$@"
}

# git log
function glg() {
  if [[ $# == 0 ]] && git rev-parse @{u} &> /dev/null; then
    git-log --graph @{u} HEAD
  else
    git-log --graph "$@"
  fi
}

$(dinghy shellinit)
eval "$(direnv hook bash)"
source ~/.fresh/build/shell.sh
