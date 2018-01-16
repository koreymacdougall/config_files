# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/km/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HISTSIZE=10000
SAVEHIST=1000
HISTFILE=~/.zsh_history
 HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
alias xmm='xmodmap ~/config_files/.xmodmap_custom_mappings'
alias ls='ls --color=auto --group-directories-first'
alias l='ls --color=auto --group-directories-first'
alias ll='ls -al --color=auto --group-directories-first'
alias grep='grep --color=always'
alias 1920='xrandr --output Virtual-1 --mode 1920x1080'

alias 2560="
xrandr --newmode '2560x1080_60.00'  230.00  2560 2720 2992 3424 1080 1083 1093 1120 -hsync +vsync; 
xrandr --addmode Virtual-1 2560x1080_60.00 ; 
xrandr --output Virtual-1 --mode 2560x1080_60.00"

# i3 power management fns
alias logout='i3-msg exit'
alias suspend='lock && systemctl suspend'


# Custom Functions

# ref_clock toggles set-ntp true
# vm's often don't update clocks properly
# if suspended for any length of time
ref_clock () {
    systemctl restart systemd-timesyncd.service
}

## go fn
# quickly nav to a dir in home dir
go () {
    p=$(find /home/$(whoami)/ -type d -name "$1*" | head -1)
    cd "$p"
}
## end go fn

## Vim last
# quickly open latest version in a writing dir
 vl () {
    vim $(ls | tail -n 1)
}


# Set vim as default editor
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# Ruby Settings
# activate rbenv
# &> /dev/null redirects stdout and stderr to nowhere
# effectively supresses error msg when rbenv is not installed
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi &> /dev/null

# Not sure if I need to source zshenv, not currently using it
#source /home/km/.zshenv

#loadkeyboard map / swap caps_lock and escape
#this is the manual method, instead of using 
#localectl set-keymap MAPPING
#/usr/bin/loadkeys /home/km/config_files/.swap_esc_capslock.kmap
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


#setup a github-create function to create repos on github 
#from the command line
#thanks to eli fatsi on viget.com
github-create() {

  invalid_credentials = 0
  echo "Make sure to check for pre-existing remotes!!!!"
  echo "Fn will fail otherwise, but you won't get an error -- sneaky"

  echo "Also make sure to set export token to env ... "

  repo_name=$1

  dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
  echo "Repo name (hit enter to use '$dir_name')?"
  read repo_name
  fi

  if [ "$repo_name" = "" ]; then
  repo_name=$dir_name
  fi

  echo "Repo name will be: $repo_name"

  username=`git config github.user`
  if [ "$username" = "" ]; then
  echo "Could not find username, run 'git config --global github.user <username>'"
  invalid_credentials=1
  fi
  echo "User name will be: $username"

  #use encrypted github_token in config file repo to set env param
  gpg -d ~/config_files/github_token.gpg 2>/dev/null | export GITHUB_TOKEN=$(sed -n 2p)
  token=$GITHUB_TOKEN
  echo "Token has been set"

  if [ "$token" = "" ]; then
  echo "Could not find token, run 'git config --global github.token <token>'"
  invalid_credentials=1
  fi

  if [ "$invalid_credentials" = "1" ]; then
  echo "Invalid credentials"
  return 1
  fi

  echo -n "Creating Github repository '$repo_name' ..."
  curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
  echo " done."

  echo -n "Pushing local code to remote ..."
  git remote add origin https://github.com/$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1

  export GITHUB_TOKEN=""
  echo "clearing env vars..."
  echo " done."
}

# set transparency
#[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" >/dev/null

bindkey -e
# bind ctrl j/k to search command history 
bindkey "^K" history-beginning-search-backward
bindkey "^J" history-beginning-search-forward
# same for vi mode
#bindkey -M viins "^K" history-beginning-search-backward
#bindkey -M viins "^J" history-beginning-search-forward


# shorten delay between mode switches
#export KEYTIMEOUT=1

# precmd() { RPROMPT="" }
# function zle-line-init zle-keymap-select {
#   VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#   zle reset-prompt
#}

zle -N zle-line-init
zle -N zle-keymap-select
