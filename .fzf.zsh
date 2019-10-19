# Setup fzf
# ---------
if [[ ! "$PATH" == */home/km/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/km/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/km/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/km/.fzf/shell/key-bindings.zsh"
