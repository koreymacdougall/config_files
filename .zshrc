####################
#### SETTINGS ######
####################

# many of the settings (zstyle and some opts) are lifted from greg hurrell:
# github.com/wincent/wincent/roles/dotfiles/files/zshrc

# autoload the completion engine
autoload -U compinit && compinit
setopt COMPLETE_ALIASES

autoload -U colors && colors

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
# via greg hurell
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}●" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}●" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b %c%u%F{6}]' # default ' (%s)-[%b]%c%u-' %F{6} colorize end bracket
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u]' # default ' (%s)-[%b|%a]%c%u-'
# zstyle ':vcs_info:hg*:*' formats '[%m%b]'
# zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m]'
# zstyle ':vcs_info:hg*:*' branchformat '%b'
# zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks 
# zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[unstaged]+='%F{15}●'
    fi
}
setopt prompt_subst
# left prompt
PROMPT='%F{9}%n%F{15}@%F{13}%m%f %B%F{10}%1~%f %F{6}${vcs_info_msg_0_}%F{15} '

# these commands are run before each prompt refresh
precmd() { vcs_info RPROMPT="" }

function zle-line-init zle-keymap-select {
   VIM_normal_PROMPT="%F{10}%~%f %F{14}[% NORMAL]%  %{$reset_color%}"
   VIM_insert_PROMPT="%F{10}%~%f %F{3}[% INSERT]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_normal_PROMPT}/(main|viins)/$VIM_insert_PROMPT} $EPS1"
   zle reset-prompt
 }

# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' menu select=0
setopt nocasematch

# set default terminal to xterm
export TERMINAL=/usr/bin/xterm

# make right prompt (NORMAL or INSERT tag) disappear after cmd executes
setopt transientrprompt
# expand wildcards and suchlike
setopt extended_glob

# Set vim as default editor
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# shorten delay between vi mode switches
export KEYTIMEOUT=1

# keep a stack of recent dirs
setopt AUTO_PUSH_D
setopt PUSHD_IGNORE_DUPS
DIRSTACKSIZE=20

# terminal history settings
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
HIST_STAMPS="mm/dd/yyyy"

# load existing pywal colorscheme to new terminals
#(cat ~/.cache/wal/sequences &)
####################
####  PLUGINS  ####
####################

# plugins found in ~/.oh-my-zsh/plugins/*)
# custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# note to self:  zsh-syntax-highlighting downloaded from
# github.com/zsh-users/zsh-syntax-highlighting
#plugins=(git bundler zsh-syntax-highlighting docker)

# rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi &> /dev/null
# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

####################
# CUSTOM FUNCTIONS #
####################

## ref_clock
# toggles set-ntp true
# vm's often don't update clocks properly
# if suspended for any length of time
ref_clock () {
    systemctl restart systemd-timesyncd.service
}

## go
# quickly nav to a dir in home dir
# go () {
#     p=$(find /home/$(whoami)/ -type d -name "$1*" | head -1)
#     cd "$p"
# }

## Vim last
# quickly open latest version in a writing dir
 vl () {
    vim $(ls | tail -n 1)
}

# github-create
#create repos on github from the command line
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

####################
####  BINDINGS  ####
####################

# bind ctrl j/k to search command history 
bindkey "^K" history-beginning-search-backward
bindkey "^J" history-beginning-search-forward
bindkey "^r" history-incremental-search-backward

# do same for vi mode
bindkey -M viins "^K" history-beginning-search-backward
bindkey -M viins "^J" history-beginning-search-forward

# map Ctrl-U (emacs binding) to vi modes
bindkey -M viins "^U" backward-kill-line
bindkey -M vicmd "^U" backward-kill-line
# map Ctrl-A (emacs binding) to vi modes
bindkey -M viins "^A" beginning-of-line
bindkey -M vicmd "^A" beginning-of-line


####################
#  VI-mode TWEAKS  #
####################

zle -N zle-line-init
zle -N zle-keymap-select

# source oh-my-zsh after resetting prompt
#source $ZSH/oh-my-zsh.sh

# bind to vi keys after everything else is loaded
bindkey -v

####################
####  ALIASES  #####
####################

## note - when these were earlier in the file, the ls aliases
## were being clobbered by something.  A plugin?
alias xmm='xmodmap ~/config_files/.xmodmap_custom_mappings'
alias lk='sudo loadkeys ~/config_files/.swap_esc_capslock.kmap'

alias ls='ls --color=auto --group-directories-first'
alias l='ls --color=auto --group-directories-first'
alias ll='ls -al --color=auto --group-directories-first'

alias history='history 0'

alias grep='grep --color=always'
alias e='exit'

alias 1920='xrandr --output Virtual-1 --mode 1920x1080'
alias 2560="
xrandr --newmode '2560x1080_60.00'  230.00  2560 2720 2992 3424 1080 1083 1093 1120 -hsync +vsync; 
xrandr --addmode Virtual-1 2560x1080_60.00 ; 
xrandr --output Virtual-1 --mode 2560x1080_60.00"

# i3 power management aliases
alias logout='i3-msg exit'
alias suspend='i3lock -c 112233 && systemctl suspend'
alias lock='i3lock -c 112233'

# tmux aliases; lifted from oh-my-zsh plugin
alias ta="tmux attach -t"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"

# git aliases
alias gst='git status'
alias gcam='git commit -am'
alias gd='git diff'
alias gp='git push origin master'
alias gl='git pull origin master'
alias grv='git remote -v'
alias git co='git checkout'
alias glog='git log --oneline --decorate --color --graph'

# movement aliases
alias mc='cd ~/config_files'
alias mm='cd ~/mail_configs'
alias me='cd ~/email'
alias md='cd ~/Downloads'

alias 1='cd ~1'
alias 2='cd ~2'
alias 3='cd ~3'
alias 4='cd ~4'
alias 5='cd ~5'
alias 6='cd ~6'
alias 7='cd ~7'
alias 8='cd ~8'
alias 9='cd ~9'

# quickly open various config files
alias vv='vim ~/.vimrc'
alias vc='vim ~/config_files/notes/cheatsheet.md'
alias vz='vim ~/.zshrc'
alias vi='vim ~/.config/i3/config'
alias vm='vim ~/.muttrc'
alias vr='vim ~/.config/ranger/rc.conf'
alias vt='vim ~/.tmux.conf'

# alias cd by .. or ... or ... or mv file ..../.
alias ".."='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# grab mail alias
alias gm='cd ~/mail_configs && bash ./cryptscript.sh'

# launch neomutt wth GPG_TTY set
### there is a gpg/tty issue sometimes when trying to send mail, 
### error is something like "inapppriate ioctl for device"
### the fix is to export this shell variable
GPG_TTY=$(tty)
export GPG_TTY

alias m='neomutt'

alias d="dirs -v"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm stuff
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
