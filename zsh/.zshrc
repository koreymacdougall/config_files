####################
#### SETTINGS ######
####################

#
# source other files
source ~/config_files/zsh/zsh_aliases
source ~/config_files/zsh/functions
source ~/config_files/zsh/styles

autoload -U compinit && compinit        # the completion engine
autoload -U colors && colors
autoload -Uz vcs_info

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[unstaged]+='%F{15}●'
    fi
}

# left prompt
PROMPT='%F{9}%n%F{15}@%F{13}%m%f %B%F{10}%1~%f %F{6}${vcs_info_msg_0_}%F{15} '

# these commands are run before each prompt refresh
precmd() { vcs_info RPROMPT="" }

# exports
export TERMINAL=/usr/bin/xterm
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export KEYTIMEOUT=1         # delay btwn mode switches
export GPG_TTY=$(tty)       # this is for neomutt
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=tmux-256color

# setopts
setopt AUTO_PUSH_D          # keep a stack of recent dirs
setopt COMPLETE_ALIASES     # autocomplete aliases
setopt PUSHD_IGNORE_DUPS    # ignore duplicate dirs
setopt extended_glob        # expand wildcards and suchlike
setopt transientrprompt     # transient right prompt
setopt prompt_subst         # allow string subs
setopt nocasematch          # case insensitive

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
bindkey -M viins "^K" history-beginning-search-backward
bindkey -M viins "^J" history-beginning-search-forward
bindkey -M viins "^U" backward-kill-line
bindkey -M vicmd "^U" backward-kill-line
bindkey -M viins "^A" beginning-of-line
bindkey -M vicmd "^A" beginning-of-line
bindkey -v                  # use vi mode

#  VI-mode tweaks
zle -N zle-line-init
zle -N zle-keymap-select

# source fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# deferred nvm loading - using bc default (above) was quite slow
# see https://github.com/creationix/nvm/issues/1277
# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# credits:
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
# via greg hurell
# github.com/wincent/wincent/roles/dotfiles/files/zshrc

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/km/dev/blockchain/test2/ganache/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/km/dev/blockchain/test2/ganache/node_modules/tabtab/.completions/electron-forge.zsh
