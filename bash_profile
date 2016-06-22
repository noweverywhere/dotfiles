export PATH="$PATH:~/bin"
source ~/bin/bash_fun.sh

alias cucumber="bundle exec cucumber"
alias rubocop="bundle exec rubocop"
alias doco="docker-compose"
alias domo="docker-machine"
alias gm="git co master"
alias be="bundle exec"

export redisstart='redis-server /usr/local/etc/redis.conf'

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export PATH="~/code/plain-utils/bin:$PATH"

ssh-add ~/.ssh/id_rsa

source /Users/marinus.swanepoel/.oh-my-git/prompt.sh
source ~/bin/git-completion.bash

eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"

export NVM_DIR="/Users/marinus.swanepoel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(direnv hook bash)"
