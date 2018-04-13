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
    " wait to lazy load it (see greg hurrells optimizing screencast)
    ""Plug 'Valloric/YouCompleteMe', { 'on': [] }
    " vim-gitbranch
    Plug 'dhruvasagar/vim-table-mode'
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


" use spacebar to toggle folding
nnoremap  <space> za

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
" if filetype is rubu or eruby, use 2 spaces for the tab
au FileType ruby,eruby,css,scss set tabstop=2 shiftwidth=2

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

" comment out all python ##print statements
nnoremap <leader>p :%s/print(/#print(/<CR>
" capital P for uncomment all prints
nnoremap <leader>P :%s/#print(/print(/<CR>

" latex helpers; specifically vimtex plugin options
let g:vimtex_view_method = 'mupdf'
let g:livepreview_previewer = 'mupdf'
"let g:vimtex_view_forward_search_on_start = 1
let g:vimtex_quickfix_latexlog = { 'overfull' : 0}
" set default pdf viewer"

""""""""""""""""""""
"" CUSTOM MAPPINGS "
""""""""""""""""""""
" remap semi-colon and colon in normal mode
nnoremap ; :
nnoremap : ;

"quick spell check; take first suggestion
nnoremap <leader><leader> z=i1<cr><cr>

" use CtrlP to look through full filesystem"
nnoremap <C-a> <Esc>:CtrlP ~<CR>

" remap capital Y to behave as D and C do
nnoremap Y y$

" source current file
nnoremap <leader>s :source %<CR>

" notmuch mappings - because I couldn't get notmuch-vim (plugin) to work
    " search
    nnoremap <leader>ns :r !notmuch search 
    " show
    nnoremap <leader>nn 0 qnq "nyiW :new \| r ! notmuch show <C-r>n<CR>gg4jzt

" use leader-cc for cursorcolumn
nnoremap <leader>cc :set cursorcolumn!<CR>

" Dim inactive windows using 'colorcolumn' setting
" This tends to slow down redrawing, but is very useful.
" Based on https://groups.google.com/d/msg/vim_use/IJU-Vk-QLJE/xz4hjPjCRBUJ
" XXX: this will only work with lines containing text (i.e. not '~')
" from
" set textwidth=80
" let &colorcolumn="80,".join(range(120,999),",")
" highlight ColorColumn ctermbg=111222 guibg=#2c2d27

" if exists('+colorcolumn')
"   function! s:DimInactiveWindows()
"     for i in range(1, tabpagewinnr(tabpagenr(), '$'))
"       let l:range = ""
"       if i != winnr()
"         if &wrap
"          " HACK: when wrapping lines is enabled, we use the maximum number
"          " of columns getting highlighted. This might get calculated by
"          " looking for the longest visible line and using a multiple of
"          " winwidth().
"          let l:width=256 " max
"         else
"          let l:width=winwidth(i)
"         endif
"         let l:range = join(range(1, l:width), ',')
"       endif
"       call setwinvar(i, '&colorcolumn', l:range)
"     endfor
"   endfunction
"   augroup DimInactiveWindows
"     au!
"     au WinEnter * call s:DimInactiveWindows()
"     au WinEnter * set cursorline
"    au WinLeave * set nocursorline
"   augroup END
" endif

" use tab to jump out of closures (quotes, brackets, etc) ; thanks to Ingo Karkat
" had removed bc tabbing on opening closure will not tab code out; should use >> anyway 
" re-adding jan/25/2018
inoremap <expr> <Tab> search('\%#[]>)}''"]', 'n') ? '<Right>' : '<Tab>'

" map leader-f to open netrw/file broswer in vsplit 
nnoremap <leader>f :Vex<cr>

" quick edit config files
" vimrc, zshrc, bashrc, cheatsheet, muttrc
    " vimrc
    nnoremap <leader>ev :e $MYVIMRC<cr>
    " bashrc
    nnoremap <leader>eb :e ~/.bashrc<cr>
    " zshrc
    nnoremap <leader>ez :e ~/.zshrc<cr>
    " cheat.sheet
    nnoremap <leader>ec :e ~/config_files/notes/cheatsheet.md<cr>
    " muttrc
    nnoremap <leader>em :e ~/mail_configs/.muttrc<cr>
    " i3 config
    nnoremap <leader>ei :e ~/config_files/i3/i3_config<cr>

" buffer navigation / manipulation
    " open a new empty buffer
    nnoremap <leader>T :enew<cr>
    " move to the next buffer
    nnoremap <leader>l :bnext<cr>
    " move to the previous buffer
    nnoremap <leader>h :bprevious<cr>
    " close current buffer and move to previous one
    " similar to closing a tab
    nnoremap <leader>bq :bp <BAR> bd # <CR>

    " show all open buffers and their status
    nnoremap <leader>bl :ls<CR>

" mappings to allow quicker navigation of the quickfix list
" also found in tpope's unimpaired; forget where I grabbed em
    nnoremap [q :cprevious<CR>
    nnoremap ]q :cnext<CR>
    nnoremap [Q :cfirst<CR>
    nnoremap ]Q :clast<CR>

" mappings to quickly resize splits
" thanks to Andy Wokula
" SID appears to be a unique script ID? 
" an appended var? 
    nmap         <C-W>+     <C-W>+<SID>winheight
    nmap         <C-W>-     <C-W>-<SID>winheight
    nmap         <C-W>>     <C-W>><SID>winwidth
    nmap         <C-W><     <C-W><<SID>winwidth
    nn <script>  <SID>winheight+   <C-W>+<SID>winheight
    nn <script>  <SID>winheight-   <C-W>-<SID>winheight
    nn <script>  <SID>winwidth>   <C-W>><SID>winwidth
    nn <script>  <SID>winwidth<   <C-W><<SID>winwidth

    "<Nop> is no action, so this disables the mapping from firing too soon?
    nmap         <SID>winheight    <Nop>
    nmap         <SID>winwidth    <Nop>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" use asterisk searching in visual mode
vnoremap * y/<C-R>"<CR>

" map .. to go up one tree level in fugitive git browsing
" this is from vimcasts...but I can't currently get it to work
" the mapping itself will work, but the conditional doesn't 
" seem to evalutate to true
" probably fugitive's implemenation has changed too much since the vimcast
" so, just stealing the shortcut idea
" thanks to Drew Neil
" autocmd User fugitive
"     \ if fugitive#buffer().type() =~# '^\(fugitive)$' |
"     \ nnoremap <buffer>.. :edit %:h<CR> |
"     \ endif
nnoremap <buffer> <leader>u :edit %:h<CR>
" window heght changed for more comfy gstatus
set previewheight=15


" autoclean fugitive objects from buffers
" thanks to vim casts / Drew Neil
autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""""""""""""
" PLUGIN SETTINGS ""
""""""""""""""""""""

" TABLEMODE settings"
nnoremap <leader>tm :TableModeToggle<CR>
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
nnoremap <leader>es :UltiSnipsEdit<CR>

" toggle LimeLight when entering/leaving Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" mappings to further reduce screen clutter/noise in Goyo
nnoremap <leader>gg :setl noshowmode noshowcmd nocursorline nocursorcolumn nosi nolist <cr>
nnoremap <leader>GG :setl showmode showcmd cursorline cursorcolumn si list<cr>
