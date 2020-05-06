"Plug - auto install itself if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

"load plugings at runtime
call plug#begin()
    " List of Plugins"
    " note that { 'on': []}  is syntax for lazy loading
    Plug 'tpope/vim-surround'
    " Plug 'tpope/vim-rails', { 'on': [] }
    " Plug 'tpope/vim-rails', { 'for': ['rails', 'ruby']}
    Plug 'tpope/vim-rails'
    Plug 'vim-ruby/vim-ruby'
    " rhubarb provides support for fugitive's Gbrowse for github
    Plug 'tpope/vim-rhubarb'
    " fugitive is a git wrapper
    Plug 'tpope/vim-fugitive'
    " obsolete? need to simlink to /.vim/plugged/xmledit/ftplugin, ln -s xml.vim html.vim
    Plug 'vim-scripts/xmledit'
    " gitgutter tracks lines that have been added/removed/changed
    Plug 'airblade/vim-gitgutter'
    " autoclose completes brackets, quotes, etc
    Plug 'vim-scripts/AutoClose'
    " Goyo and limelight are for minimalist writing views
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    " Provide some functionality for markdown editing
    ""Plug 'plasticboy/vim-markdown'
    " tcomment toggles comments
    Plug 'tomtom/tcomment_vim'
    "vim-latex-live-preview allows realtime preview of latex files
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    " vimtex for compiling latex in vim
    Plug 'lervag/vimtex'
    " ctrl-p fuzzyfinds files and buffers
    Plug 'ctrlpvim/ctrlp.vim'
    " ultisnips inserts snippets, i.e., predefined chunks
    Plug 'SirVer/ultisnips'
    " TableMode for easily generating tables
    Plug 'dhruvasagar/vim-table-mode'
    " syntax highlighting for solidity
    " Plug 'tomlion/vim-solidity'
    " generate markdown table of contents
    Plug 'mzlogin/vim-markdown-toc'
    " gruvbox colortheme
    Plug 'morhetz/gruvbox'
    " dracula colortheme
    Plug 'koreymacdougall/dracula'
    " molokai colortheme
    Plug 'koreymacdougall/molokai'
    " solarized colortheme
    Plug 'altercation/vim-colors-solarized'
    " Calendar mode
    " Plug 'mattn/calendar-vim'
    " speed up folding
    Plug 'Konfekt/FastFold'
    " NERDtree
    Plug 'preservim/nerdtree'
    " NERDtree plugin to show git status flags
    Plug 'Xuyuanp/nerdtree-git-plugin'


    " ------------------------------------- "
    " ---- Javascript-specific plugins ---- "
    " ------------------------------------- "
    " Prettier - Opionated JS formatting tool
    " Using npm installed version atm
    " post install (yarn install | npm install)
    " Plug 'prettier/vim-prettier', { 'do': 'npm install' }
    " Ale - Asynchronous Linting Engine
    Plug 'w0rp/ale', { 'do': 'npm install' }

call plug#end()

"lazy loading
""autocmd CursorHold * call plug#load('YouCompleteMe') | call youcompleteme#Enable() 
