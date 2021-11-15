" source ~/config_files/vim/plug.vim
source ~/config_files/vim/functions.vim
source ~/config_files/vim/settings.vim
source ~/config_files/vim/mappings.vim
source ~/config_files/vim/autocmds.vim
syntax on|                                           "turn on syntax completion - C-x C-o
filetype plugin indent on|                           "enable filetype detection, load plugins and indent files

" these 2 need to be set after colorscheme;
" they don't seem to register if called immediately after (in settings.vim)
highlight CursorLine gui=underline guibg=NONE cterm=underline ctermbg=NONE
"don't highlight the git gutter
highlight clear SignColumn
" colorscheme default
