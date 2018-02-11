""""""""""""""""""""
" PLUGINS w/ PLUG  "
""""""""""""""""""""

" Plug - auto install if not present
" Note that PlugInstall will manually install any new plugins
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Plug functionality, load the plugings at runtime
call plug#begin()
    " List of Plugins"
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-rails'
    " rhubarb provides support for fugitive's Gbrowse for github
    Plug 'tpope/vim-rhubarb'
    " fugitive is a git wrapper
    Plug 'tpope/vim-fugitive'
    " obsolete? need to simlink to /.vim/plugged/xmledit/ftplugin, ln -s xml.vim html.vim
    Plug 'vim-scripts/xmledit'
    " airline is a status-line plugin, modeled after powerline
    Plug 'vim-airline/vim-airline'
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
    " vim-latex-live-preview allows realtime preview of latex files
    "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    " vimtex for compiling latex in vim
    Plug 'lervag/vimtex'
    " gruvbox is a colorscheme 
    Plug 'morhetz/gruvbox'
    " ctrl-p fuzzyfinds files and buffers
    Plug 'ctrlpvim/ctrlp.vim'
    " ultisnips inserts snippets, i.e., predefined chunks
    Plug 'SirVer/ultisnips'
call plug#end()

" make sure dot files how up in ctrlp
let g:ctrlp_show_hidden=1

""""""""""""""""""""
""""" SETTINGS """""
""""""""""""""""""""

" shorten time (ms) before screen is updated, done for gitgutter
set updatetime=250

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
exec "set listchars=tab:\uBB\uBB,nbsp:~,trail:\u2022"
set list

" remap leader to comma
let mapleader=','

" folding options
" use manual folding typically
set foldmethod=manual
" set default foldlevel to 1
set foldlevelstart=1
" make folds reclose when exiting them with cursor
" set foldclose=all

" save and load folding patterns when exiting/entering a file
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" setup markdown levels for folding
" TODO - find reference for this
function MarkdownLevel()
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
filetype plugin indent on
au FileType php				setl omnifunc=phpcomplete#CompletePHP
au FileType ruby,eruby		setl ofu=rubycomplete#Complete
au FileType html,xhtml		setl ofu=htmlcomplete#CompleteTags
au FileType css				setl ofu=csscomplete#CompleteCSS
au FileType javascipt		setl ofu=js#CompleteJS

" turn on syntax folding for various languages
let javaScript_fold=1         " JavaScript
let php_folding=1             " PHP
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" sets when the last window will have a status line, 2 = always
set laststatus=2

" show command while typing it
set showcmd

" set vim to dark background
set background=dark
" set terminal to 256 colors
set t_Co=256

" default colorschemes: industry for code, murphy for markdown
colorscheme gruvbox
" au FileType markdown colorscheme murphy

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
set autochdir
" or try for each buffer
"autocmdBufEnter * silent! cd %:p:h

" comment out all python ##print statements
nnoremap <leader>p :%s/print(/#print(/<CR>
" capital P for uncomment all prints
nnoremap <leader>P :%s/#print(/print(/<CR>

" latex helpers; specifically vimtex plugin options
let g:vimtex_view_method = 'mupdf'
" "let g:vimtex_view_forward_search_on_start = 1
let g:vimtex_quickfix_latexlog = { 'overfull' : 0}

"quick spell check; take first suggestion
nnoremap <leader><leader> z=i1<cr><cr>

"### speed maps ###
"run file: temporary for dol proj
"note that the external call to xfce4-terminal is b/c xterm flickers here
"the flicker can apparently be fixed if compiling xterm with
" --enable-double-buffering (not sure of proper form of the flag) but I've not
"  figured out how to compile xterm from source on arch or parabola
"nnoremap <leader><leader> :! xfce4-terminal -e 'python  ./batch_runner.py'  <CR>

""""""""""""""""""""
" CUSTOM MAPPINGS ""
""""""""""""""""""""

" remap semi-colon and colon in normal mode
nnoremap ; :
nnoremap : ;

" use leader-cc for cursorcolumn
nnoremap <leader>cc :set cursorcolumn!<CR>

" use tab to jump out of closures (quotes, brackets, etc)
" thanks to Ingo Karkat
" had removed....forget why; re-adding jan/25/2018
inoremap <expr> <Tab> search('\%#[]>)}''"]', 'n') ? '<Right>' : '<Tab>'

" Snippets
" deprecated; now using ultisnips
    " auto insert eruby tags
    " insert embedded ruby w/ display tag
    " nnoremap <leader>er i<%=  %><left><left><left>
    " insert embedded ruby tag
    " nnoremap <leader>ER i<%  %><cr><cr><% end %><up><up><left><left><left>
" deprecated (replaced by tcomment plugin)custom comments for html and css deprecated"
    " " insert html comment
    " nnoremap <leader>wc a<!----><left><left><left>
    " " insert css comment
    " nnoremap <leader>cc a/**/<left><left>

" reformat entire file - gq is format cmd
nnoremap <leader>q gggqG<C-O><C-O>

" map leader-f to open netrw/file broswer in vsplit 
nnoremap <leader>f :Vex<cr>

" quick edit config files
" vimrc, zshrc, bashrc, cheatsheet
    " map leader-ev to open .vimrc in a new Vert split
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    " map leader-eb to open .bashrc in a new vert split
    nnoremap <leader>eb :vsplit ~/.bashrc<cr>
    " map leader-f to open .zshrc in vsplit 
    nnoremap <leader>ez :vsplit ~/.zshrc<cr>
    " map leader-f to open .zshrc in vsplit 
    nnoremap <leader>ec :vsplit ~/config_files/cheat.sheet<cr>

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

" ultisnips trigger configuration"
let g:UltiSnipsExpandTrigger="<S-Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
nnoremap <leader>s :UltiSnipsEdit<CR>

" air-line
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" toggle LimeLight when entering/leaving Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" most of these unicode/powerline old powerline symbols just kept for reference
" unicode symbols
let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = '☰'
"let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
" old vim-powerline symbols
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_powerline_fonts = 1
" Airline - enable the list of buffers
"let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#tabline#enabled = 1
" Airline - show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline_section_b
let g:airline#extensions#branch#enabled = 1
