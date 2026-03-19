yellow='\033[0;33m'
cyan='\033[1;36m'
reset=`tput sgr0`

update () {
  git co master
  git fetch --prune
  git pull
  destroy_merged_branches
}

destroy_merged_branches () {
  git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
}

branchbydate () {
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname)|%(committerdate)|%(authorname)' | sed 's/refs\/heads\///g' | column -t -s "|"
}

#git branch
gbr () {
  givenName=$*
  branchName=${givenName// /_}
  git co -b $branchName
}

weather () {
  city=${*-edmonton}
  curl "v2.wttr.in/${city}"
}

whoson () {
  lsof -nP -i4TCP:$1 | grep LISTEN
}

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

# protect AWS secrets
# https://github.com/awslabs/git-secrets
# run this in every repo to prevent secrets leaking
function protect-secrets() {
  git secrets --install
  git secrets --register-aws
}

function lswc() {
  dir=${*-.}
  ls $dir | wc -l
}

function setup_shared_tmux_socket() {
  local socket_path=${1:-/tmp/shared_tmux/shared}
  mkdir -p /tmp/shared_tmux/
  touch $socket_path
  chgrp brew $socket_path
}


dotfiles() {
  local session="Dotfiles"
  local base_dir="$HOME/code/personal/dotfiles"

  if tmux  has-session -t "$session" 2>/dev/null; then
    tmux  attach -t "$session"
    return
  fi

  tmux  new -s "$session" -c $base_dir -d

  local name="Edit"
  local dir="$base_dir"
  tmux new-window -t "$session" -n "$name" -c "$dir"
  tmux split-window -h -t "$session:$name" -c "$dir"
  # tmux send-keys -t "$session:$name.0" ""
  tmux send-keys -t "$session:$name.1" "nvim"
}

push_current_and_master_and_last_tag_by_date() {
  local current_branch=$(git branch --show-current)

  if [[ -z "$current_branch" ]]; then
    echo "Error: Could not determine current branch."
    return 1
  fi

  local last_tag=$(git for-each-ref --sort='-creatordate' --format='%(refname:short)' refs/tags | head -n 1)

  git push origin "$current_branch" master

  if [[ $? -eq 0 ]]; then
    echo "Successfully pushed $current_branch and master to origin."
  else
    echo "Error: Failed to push $current_branch and master."
    return 1
  fi

  if [[ ! -z "$last_tag" ]]; then
      git push origin "refs/tags/$last_tag"
      if [[ $? -eq 0 ]]; then
          echo "Successfully pushed last tag by date '$last_tag' to origin."
      else
          echo "Warning: Failed to push last tag by date '$last_tag'."
      fi
  else
      echo "No tags found. Skipping tag push."
  fi
  git checkout master
}
alias git_flow_finish='push_current_and_master_and_last_tag_by_date'
alias gff='git_flow_finish'

# Load machine-/context-specific aliases that should not be committed
for f in \
  "$HOME/.config/shell/shell_help.local.sh" \
  "$HOME/.shell_help.local.sh" \
  "${DOTFILES:-$HOME/code/personal/dotfiles}/shell/shell_help.local.sh"
do
  [ -f "$f" ] && . "$f"
done
