####################
#### SETTINGS ######
####################

# source other files
source ~/config_files/zsh/functions
source ~/config_files/zsh/styles
source ~/config_files/zsh/zsh_aliases

autoload -Uz compinit && compinit        # the completion engine
autoload -U colors && colors
autoload -Uz vcs_info
autoload -U edit-command-line

# Vi style:
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[unstaged]+='%F{15}●'
    fi
}

# left prompt
PROMPT='%F{9}%n%F{15}@%F{13}%m%f %B%F{10}%1~%f %F{6}${vcs_info_msg_0_}%F{foreground} '

# these commands are run before each prompt refresh
precmd() { vcs_info RPROMPT="" }

# exports
export TERMINAL=/usr/bin/xterm
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export KEYTIMEOUT=1         # delay btwn mode switches
export GPG_TTY=$(tty)       # this is for neomutt
export bg_color="$(awk -F':' '/background/{gsub(" |\t",""); print $2}' ~/.Xresources)"

# setopts
setopt auto_pushd           # keep a stack of recent dirs
setopt complete_aliases     # autocomplete aliases
setopt pushd_ignore_dups    # ignore duplicate dirs
setopt HIST_IGNORE_DUPS     # don't store duplicates of commands
setopt extended_glob        # expand wildcards and suchlike
setopt transientrprompt     # transient right prompt
setopt prompt_subst         # allow string subs
setopt nocasematch          # case insensitive
setopt share_history        # share history between shells
setopt auto_cd              # change dir without cd

# settings
DIRSTACKSIZE=20             # number to keep in dir stack
HISTSIZE=100000             # number of lines in working hist
SAVEHIST=100000             # numbre of lines in hist file
HISTFILE=~/.zsh_history     # where to save histfile
HIST_STAMPS="mm/dd/yyyy"    # timestamps for history / unused?

####################
####  BINDINGS  ####
####################

bindkey "^K" history-beginning-search-backward
bindkey "^J" history-beginning-search-forward
bindkey "^r" history-incremental-search-backward
# bindkey "^f" FZF_CTRL_T_COMMAND
bindkey -M viins "^K" history-beginning-search-backward
bindkey -M viins "^J" history-beginning-search-forward
bindkey -M viins "^U" backward-kill-line
bindkey -M vicmd "^U" backward-kill-line
bindkey -M viins "^A" beginning-of-line
bindkey -M vicmd "^A" beginning-of-line
bindkey -M vicmd "v"  edit-command-line
bindkey -M viins '\e.' insert-last-word   # will paste laste word from last command

bindkey -v                  # use vi mode

#  VI-mode tweaks
zle -N zle-line-init
zle -N zle-keymap-select
zle -N edit-command-line  # enable edit-command-line (edit command in $EDITOR)

# source fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# re-source dircolors...b/c tmux is not picking up LS_COLORS
eval "$(dircolors ~/config_files/dircolors)"

# set gPodder to download to my podcasts dir
export GPODDER_DOWNLOAD_DIR=~/podcasts

# add youtube-dl to path
PATH="$PATH:/home/km/.local/bin";export PATH

# source chruby
# source /usr/local/share/chruby/chruby.sh
# automatically load specific ruby version if specified in a .ruby-version file
# source /usr/local/share/chruby/auto.sh
# on load, change to specified ruby (i.e., my current default is 2.5.1)
# chruby 2.5.1

# use source-highlight in place of less, to get syntax coloring
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
