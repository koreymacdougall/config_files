source ~/config_files/vim/functions
source ~/config_files/vim/settings
source ~/config_files/vim/mappings
source ~/config_files/vim/autocmds
source ~/config_files/vim/plug

syntax on|                                           "turn on syntax completion - C-x C-o
filetype plugin indent on|                           "enable filetype detection, load plugins and indent files
highlight Search ctermfg=green ctermbg=red|          "search highlighting colours
highlight clear SignColumn|                          "don't highlight the git gutter
colorscheme molokai
