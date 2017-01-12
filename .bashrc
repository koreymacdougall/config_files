#
# ~/.bashrc
#

#activate rbenv 
eval "$(rbenv init -)"

localectl set-keymap --no-convert us.map_custom

#add rbenv to $PATH
PATH="$HOME/.rbenv/bin:$PATH"

#add RubyGems path to $PATH
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Aliases
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias ll='ls -al --color=auto'

#Prompt options
PS1='[\u@\h \W]\$ '

setterm -foreground yellow --bold on --store&>/dev/null
