
source ~/config_files/vim/plug.vim
source ~/config_files/vim/functions.vim
source ~/config_files/vim/settings.vim
source ~/config_files/vim/mappings.vim
source ~/config_files/vim/autocmds.vim

syntax on|                                           "turn on syntax completion - C-x C-o
filetype plugin indent on|                           "enable filetype detection, load plugins and indent files
highlight Search ctermfg=green ctermbg=red|          "search highlighting colours
highlight clear SignColumn|                          "don't highlight the git gutter
colorscheme gruvbox


