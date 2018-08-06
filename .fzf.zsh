# Setup fzf
# ---------
if [[ ! "$PATH" == */home/km/source_packages/fzf/bin* ]]; then
  export PATH="$PATH:/home/km/source_packages/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/km/source_packages/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/km/source_packages/fzf/shell/key-bindings.zsh"

