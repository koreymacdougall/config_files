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


set completion-ignore-case on

#to swap caps and escape
#localectl set-keymap --no-convert us.map_custom


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Aliases
alias xmm='xmodmap ~/config_files/.xmodmap'
alias ls='ls --color=auto --group-directories-first'
alias l='ls --color=auto --group-directories-first'
alias ll='ls -al --color=auto --group-directories-first'

#Prompt options
#export PS1="\e[1;33m\u@\h \w $ \n--> \e[m"

#set terminal colour; is overridden if using a terminal 
#emulator such as terminator (useful for arch)
# setterm -foreground yellow --bold on --store

#git command tab completion
if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

#Ruby Settings

#add rbenv to $PATH
#PATH="$HOME/.rbenv/bin:$PATH"

#activate rbenv 
#eval "$(rbenv init -)"

#add RubyGems path to $PATH
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"


# (2021-10-28) Below has been long inactive
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#