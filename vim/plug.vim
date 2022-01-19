"Plug - auto install itself if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

"load plugings at runtime
call plug#begin()
    " Syntax support for multiple language
    Plug 'sheerun/vim-polyglot'

    " Tracks lines that have been added/removed/changed
    Plug 'airblade/vim-gitgutter'

    " fuzzyfinds files and buffers
    Plug 'ctrlpvim/ctrlp.vim'

    " Svelete syntax highlighting
    Plug 'evanleck/vim-svelte', {'branch': 'main'}

    " NERDtree (sorry netrw. ghost buffer trees RIP)
    Plug 'preservim/nerdtree'

    " helpers for editing html/xml
    Plug 'vim-scripts/xmledit'

    " For JSX highlighting
    "Plug 'maxmellon/vim-jsx-pretty'

    Plug 'tpope/vim-surround'

    " repeat mainly for vim-surround
    "Plug 'tpope/vim-repeat'

    " note that { 'on': []}  is syntax for lazy loading
    " Plug 'tpope/vim-rails', { 'on': [] }

    " Plug 'tpope/vim-rails', { 'for': ['rails', 'ruby']}
    "Plug 'tpope/vim-rails'

    "Plug 'vim-ruby/vim-ruby'

    " rhubarb provides support for fugitive's Gbrowse for github
    "Plug 'tpope/vim-rhubarb'

    " fugitive is a git wrapper
    "Plug 'tpope/vim-fugitive'


    " autoclose completes brackets, quotes, etc
    Plug 'vim-scripts/AutoClose'
    "
    " Goyo and limelight are for minimalist writing views
    "Plug 'junegunn/goyo.vim'
    "Plug 'junegunn/limelight.vim'

    " Provide some functionality for markdown editing
    "Plug 'plasticboy/vim-markdown'

    " tcomment toggles comments (gcc)
    "Plug 'tomtom/tcomment_vim'

    "vim-latex-live-preview allows realtime preview of latex files
    "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

    " vimtex for compiling latex in vim
    "Plug 'lervag/vimtex'

    " ultisnips inserts snippets, i.e., predefined chunks
    "Plug 'SirVer/ultisnips'

    " TableMode for easily generating tables
    " Plug 'dhruvasagar/vim-table-mode'

    " syntax highlighting for solidity
    " Plug 'tomlion/vim-solidity'

    " generate markdown table of contents
    "Plug 'mzlogin/vim-markdown-toc'

    "----- Colors / themes -----"
    " gruvbox colortheme
    "Plug 'morhetz/gruvbox'

    " dracula colortheme
    "Plug 'koreymacdougall/dracula'

    " molokai colortheme
    "Plug 'koreymacdougall/molokai'

    " solarized colortheme
    "Plug 'altercation/vim-colors-solarized'
    
    " Calendar mode
    " Plug 'mattn/calendar-vim'

    " speed up folding
    "Plug 'Konfekt/FastFold'

    " NERDtree plugin to show git status flags - 2020-05-06
    "Plug 'Xuyuanp/nerdtree-git-plugin'

    "  vim-indent-guides to show indentation levels - 2020-06-04 
    " Plug 'nathanaelkane/vim-indent-guides'
    "
    "Indentline for showing bars where code is indented
    "Plug 'Yggdroot/indentLine'

    " autocompletion
    " Plug 'ycm-core/YouCompleteMe'

    " " autocompletion for python
    " Plug 'davidhalter/jedi-vim'

    " ------------------------------------- "
    " ---- Javascript-specific plugins ---- "
    " ------------------------------------- "
    " Prettier - Opionated JS formatting tool
    " Using npm installed version atm
    " post install (yarn install | npm install)
    " Plug 'prettier/vim-prettier', { 'do': 'npm install' }
    " Ale - Asynchronous Linting Engine
    "Plug 'w0rp/ale', { 'do': 'npm install' }

call plug#end()

"lazy loading
""autocmd CursorHold * call plug#load('YouCompleteMe') | call youcompleteme#Enable() 
