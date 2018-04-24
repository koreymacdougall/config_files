source ~/config_files/vim/mappings

""""""""""""""""""""
" PLUGINS w/ PLUG  "
""""""""""""""""""""

" Plug - auto install if not present
" Note that PlugInstall will manually install any new plugins
" and that PlugClean will remove any commented out plugins
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

"adding a comment line"

" Plug functionality, load the plugings at runtime
call plug#begin()
    " List of Plugins"
    " note that { 'on': []}  is syntax for lazy loading
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-rails', { 'on': [] }
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
    " TODO - look into this
    Plug 'plasticboy/vim-markdown'
    " tcomment toggles comments
    Plug 'tomtom/tcomment_vim'
    "vim-latex-live-preview allows realtime preview of latex files
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    " vimtex for compiling latex in vim
    Plug 'lervag/vimtex'
    " gruvbox is a colorscheme 
    Plug 'morhetz/gruvbox'
    " ctrl-p fuzzyfinds files and buffers
    Plug 'ctrlpvim/ctrlp.vim'
    " ultisnips inserts snippets, i.e., predefined chunks
    Plug 'SirVer/ultisnips'
    " TableMode for easily generating tables
    Plug 'dhruvasagar/vim-table-mode'
    " autocompletion engine
    "Plug 'Valloric/YouCompleteMe', { 'on': [] }
    " syntax highlighting for solidity
    Plug 'tomlion/vim-solidity'

call plug#end()

" lax these modules below lazily"

" set time before screen is updated
set updatetime=500

" setup lazy loading
""au CursorHold * :echo "ecasdc"
  ""autocmd CursorHold call plug#load('vim-rails') \ | autocmd! load_vim-rails
""autocmd CursorHold * call plug#load('YouCompleteMe') | call youcompleteme#Enable() 
" augroup load_slow_plugins
"   autocmd CursorHold * call plug#load('vim-airline')
"   " autocmd! CursorHold
" augroup END

" make sure dot files how up in ctrlp
" not used if ctrlp_user_command is set
"let g:ctrlp_show_hidden=1

let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0

 let g:ctrlp_follow_symlinks=1

 " can't get ag to work correctly 
 if executable('ag')
     set grepprg=ag\ --nogroup\ --nocolor
     let g:ctrlp_user_command = 'ag %s --hidden --nocolor -l -g ""'
 endif


""""""""""""""""""""
""""" SETTINGS """""
""""""""""""""""""""

" append project root dir and subdirs to path when opening vim
" this is useful for filename completion
set path+=**

" turn on the autocomplete menu
set wildmenu

" do case sensitive searching if any caps in search string
set ignorecase
set smartcase

" show tabs, spaces, and trailing spaces
" thanks to damian conway - more instantly better vim
exec  "set listchars=tab:\uBB\uBB,nbsp:~,trail:\u2022"
set list

" remap leader to comma
let mapleader=','

let g:ycm_server_python_interpreter = '/usr/bin/python2'
" folding options
" use manual folding typically
set foldmethod=manual
" set default foldlevel to 1
set foldlevelstart=1
" make folds reclose when exiting them with cursor
" set foldclose=all

" save and load folding patterns when exiting/entering a file
au BufWinLeave * mkview
au BufRead * silent! loadview
" au BufWinEnter * silent! loadview

" setup markdown levels for folding
" the bang was added bc sourcing this file throws a time-wasting error
" TODO - find reference for this
function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

" use custom folding setup for markdown files
au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr

" folding options for .tex files
au BufEnter *.tex setlocal foldmethod=expr
au BufEnter *.tex  set foldexpr=vimtex#fold#level(v:lnum)
au BufEnter *.tex  set foldtext=vimtex#fold#text()
"au BufEnter *.tex let g:vimtex_fold_enabledmd



" netrw tree view, banner, winsize
" show netrw split in tree style"
let g:netrw_liststyle=3
" hide the netrw shortcut banner
let g:netrw_banner=0
" set split width to 25%
let g:netrw_winsize=25
" when opening a file, show it in previous pane
let g:netrw_browse_split=4
" shows browser pane on left (I think)
let g:netrw_altv = 1
" project drawer view as default when opening vim
"augroup ProjectDrawer
  "autocmd!
  "autocmd VimEnter * :Vexplore
"augroup END

" turn on line numbering
set number relativenumber

" set limelight dim color
let g:limelight_conceal_ctermfg = 'gray'

" allows buffer to be hidden if you've modified the buffer
set hidden

" turn on smart indent and autoindent
set si ai

" text display options; window wrap, linebreak, textwidth
set wrap linebreak tw=80

" turn on underline
set cursorline
" turn on cursorcolumn highlight
set cursorcolumn

" set tab key to indent 4 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" if filetype is one of these, use 2 spaces for the tab
au FileType ruby,eruby,css,scss,javascript,solidity set tabstop=2 shiftwidth=2

" turn on syntax completion - C-x C-o
syntax on

" set regular expression engine to the old one, as it works faster for ruby
set re=1

filetype plugin indent on
au FileType php				setl omnifunc=phpcomplete#CompletePHP
au FileType ruby,eruby		setl ofu=rubycomplete#Complete
au FileType html,xhtml		setl ofu=htmlcomplete#CompleteTags
au FileType css				setl ofu=csscomplete#CompleteCSS
au FileType javascipt		setl ofu=js#CompleteJS

set complete=.,b,u,]
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

" turn on spell checking for emails (mutt)
autocmd BufNewFile,BufRead,BufEnter /tmp/neomutt* set filetype=mail
au FileType mail            setlocal spell nocursorcolumn nohlsearch
au FileType mail            colorscheme murphy


" turn on syntax folding for various languages
let javaScript_fold=1         " JavaScript
let php_folding=1             " PHP
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" define status line - adapted from tpopes
set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()[4:-2]}\ %h%w%m%r%y%=%-16(\ %l,%c-%v\ %)%P
" sets when the last window will have a status line, 2 = always
set laststatus=2

" show command while typing it
set showcmd

" set vim to dark background
set background=dark
" set terminal to 256 colors
set t_Co=256

colorscheme gruvbox

" highlight serarch results
set hlsearch
" start matching pattern while typing
set incsearch

" search highlighting colours
hi Search ctermfg=green ctermbg=red

" fold text; show hidden lines etc
set foldtext=MyFoldText() 
function! MyFoldText()
    let nblines = v:foldend - v:foldstart + 1
    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0) - 6
    let line = getline(v:foldstart)
    let comment = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    #let level = s/\#/line/gn
    let level = len(matchstr(getline(v:foldstart), '^#\+'))
    let level2 = repeat("  ", level)
    let expansionString = repeat(".", w - strwidth(nblines.comment.'"'))
    let txt = '"' . level2  . comment . expansionString . nblines . " lines"
    return txt
endfunction

" execute folding everytime a file is opened 
" (neeed for opening files w/ netrw)
au FileType * setlocal foldtext=MyFoldText()

" automatically set the pwd to the dir of open file
" set autochdir
" or try for each buffer
" autocmdBufEnter * silent! cd %:p:h

" latex helpers; specifically vimtex plugin options
let g:vimtex_view_method = 'mupdf'
let g:livepreview_previewer = 'mupdf'
"let g:vimtex_view_forward_search_on_start = 1
let g:vimtex_quickfix_latexlog = { 'overfull' : 0}

" window heght changed for more comfy gstatus
set previewheight=15

" autoclean fugitive objects from buffers
" thanks to vim casts / Drew Neil
autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""""""""""""
" PLUGIN SETTINGS ""
""""""""""""""""""""

" TABLEMODE settings"
"Key Remappings
  augroup table_mode_on_mappings
      au!
      " remap carriage return while in TableMode to auto-inesrt a pipe on new line
      au User TableModeEnabled inoremap <CR> \|<CR>\|
      " remap o (for newline) while in TableMode to new line and auto-inesrt a pipe on new line
      au User TableModeEnabled nnoremap o o\|
      " remap tab while in TableMode to auto-insert a pipe
      au User TableModeEnabled inoremap <TAB> \|
  augroup end

  augroup table_mode_off_mappings
      au!
      au User TableModeDisabled iunmap <CR>
      au User TableModeDisabled nunmap o
      au User TableModeDisabled iunmap <TAB>
  augroup end

" ultisnips trigger configuration"
let g:UltiSnipsExpandTrigger="<S-Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" quickly edit the UltiSnips file for this file type

" toggle LimeLight when entering/leaving Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
