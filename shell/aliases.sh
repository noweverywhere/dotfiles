# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias maketags='ctags -R --exclude=.git --exclude=node_modules --exclude=test -f tags'

# docker related stuff
alias doco="docker-compose"

alias be="bundle exec"
alias brs="be rspec"

alias please="sudo !!"
alias tree="tree -I node_modules"
alias :e=vim

alias clean-branches="git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"

alias current_branch="git rev-parse --abbrev-ref HEAD"

alias same_remote="git branch --set-upstream-to=origin/\$(current_branch) \$(current_branch)"

alias erb_lint="bundle exec erblint app/**/*.{html,js,text}{+*,}.erb --autocorrect"
