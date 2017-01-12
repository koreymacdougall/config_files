#
# ~/.bashrc
#

#activate rbenv 
eval "$(rbenv init -)"

#add rbenv to $PATH
PATH="$HOME/.rbenv/bin:$PATH"

#add RubyGems path to $PATH
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls --color=auto'
alias ll='ls -al --color=auto'

PS1='[\u@\h \W]\$ '

setterm -foreground yellow --bold on --store


