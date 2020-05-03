
source ~/config_files/vim/plug.vim
source ~/config_files/vim/functions.vim
source ~/config_files/vim/settings.vim
source ~/config_files/vim/mappings.vim
source ~/config_files/vim/autocmds.vim

syntax on|                                           "turn on syntax completion - C-x C-o
filetype plugin indent on|                           "enable filetype detection, load plugins and indent files

highlight Search ctermfg=green ctermbg=red|          "search highlighting colours
highlight clear SignColumn|                          "don't highlight the git gutter

" the two settings below will make highlighted row use underline, not bg color"
" they need to be sourced after colorscheme... so they are here in vimrc
highlight clear Cursorline
highlight CursorLine gui=underline guibg=NONE cterm=underline ctermbg=NONE

" note that light themes don't work well if xresources not using a light theme
set background=dark
colorscheme gruvbox


