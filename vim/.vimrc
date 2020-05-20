
source ~/config_files/vim/plug.vim
source ~/config_files/vim/functions.vim
source ~/config_files/vim/settings.vim
source ~/config_files/vim/mappings.vim
source ~/config_files/vim/autocmds.vim
" fb4934
syntax on|                                           "turn on syntax completion - C-x C-o
filetype plugin indent on|                           "enable filetype detection, load plugins and indent files

" this needs to be set after colorscheme; doesn't seem to register if
" called immediately after (in settings.vim)
highlight CursorLine gui=underline guibg=NONE cterm=underline ctermbg=NONE
