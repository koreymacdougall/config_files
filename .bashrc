#
# ~/.bashrc
#
#######################
####### notes #########
#######################

#for tab completion case insensitive,
#add this to /etc/inputrc:
#set completion-ignore-case on

#######################
##### end notes #######
#######################

#activate rbenv 
eval "$(rbenv init -)"

set completion-ignore-case on

localectl set-keymap --no-convert us.map_custom

#add rbenv to $PATH
PATH="$HOME/.rbenv/bin:$PATH"

#add RubyGems path to $PATH
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Aliases
alias ls='ls --color=auto --group-directories-first'
alias l='ls --color=auto --group-directories-first'
alias ll='ls -al --color=auto --group-directories-first'

#Prompt options
export PS1="\e[1;33m\u@\h \w $ \n--> \e[m"

function cd_up(){
    cd $(printf "%0.0s../" $(seq 1 $1));
}
alias 'cd..'='cd_up'

#set terminal colour; is overridden if using a terminal 
#emulator such as terminator (useful for arch)
setterm -foreground yellow --bold on --store
