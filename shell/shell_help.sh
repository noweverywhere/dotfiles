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

cuke () {
  changed_cukes=`git status --porcelain | grep -E '.feature$' | cut -d' ' -f3`
  cuke_to_run=${*-$changed_cukes}
  echo -e "${cyan}${cuke_to_run}${reset}"
  mv $HOME/code/website/tmp/capybara/* $HOME/code/website_cucumber_screenshots/;
  bundle exec cucumber $cuke_to_run;
  exit_code=$?
  if [[ $exit_code != 0 ]]
    then open $HOME/code/website/tmp/capybara/*.png;
  fi
}

title () {
 echo -e '\033]2;'$*'\007'
}

flow () {
  givenName=$*
  branchName=${givenName// /-}
  if [[ $givenName =~ ^GTU-[0-9] ]]; then
    git co -b 'feature/'$branchName
  else
    echo -e "${yellow}Features must start with story title/id like 'GTU-1234'${reset}"
  fi
}

#git branch
br () {
 givenName=$*
 branchName=${givenName// /-}
 git co -b $branchName
}

weather () {
 city=${*-nanaimo}
 curl "v2.wttr.in/${city}"
}

whoson () {
  lsof -nP -i4TCP:$1 | grep LISTEN
}

agreplace () {
 from=$1
 to=$2
 echo "change ${from}, with ${to}"
 ag "${from}" --nogroup | awk '{print substr($1,1,index($1,":")-1);}' | xargs -I {} sed -i .bak -e 's/${from}/${to}/g' {}
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
