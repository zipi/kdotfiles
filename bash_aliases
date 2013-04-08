# kubuntu specifics
alias say='espeak >& /dev/null'

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

# bundler shortcuts
alias ber='bundle exec rake'
alias be='bundle exec'
alias bmt='bundle exec rake db:migrate; bundle exec rake test && say "yaba dabba doo"'

alias glfull='git pull && bundle && rake db:drop db:create:all db:migrate; rake db:seed; rake test:hot:db:prepare; time rake test:hot && say done'
alias rf='git pull && bundle && rake db:migrate; rake test:hot:db:prepare; time rake test:hot && say whoop'
