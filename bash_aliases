# kubuntu specifics
alias say='espeak >& /dev/null'
alias ack='ack-grep'

#sno work
alias snossh='ssh -i ~/.ssh/simplified/id_rsa'

# handy git shortcuts
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gco="git checkout"
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gp='git push'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gst='git status'
alias gsp='git status --porcelain'

# node coffee zombie express
alias ns='(coffee --compile --watch routes/&); nodemon app.js' # node server

alias open='xdg-open'


function viewmd() {
  markdown $1 | w3m -T text/html
}
alias lmd=viewmd
