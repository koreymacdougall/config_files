" Plug - auto install if not present
" Note that PlugInstall will manually install any new plugins
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Plug functionality, load the plugings at runtime
call plug#begin()
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
call plug#end()

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
" use cold folding, syntax-wise
set foldmethod=syntax
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
au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr

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

" toggle LimeLight when entering/leaving Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" set limelight dim color

let g:limelight_conceal_ctermfg = 'gray'

"CUSTOM MAPPINGS

"       Snippets
" auto insert eruby tags
" insert embedded ruby w/ display tag
nnoremap <leader>er <%=  %><left><left><left>
" insert embedded ruby tag
nnoremap <leader>ER <%  %><cr><cr><% end %><up><up><left><left><left>
" insert html comment
nnoremap <leader>wc a<!----><left><left><left>
" insert css comment
nnoremap <leader>cc a/**/<left><left>

" remap semi-colon and colon in normal mode
nnoremap ; :
nnoremap : ;
" reformat entire file - gq is format cmd
nnoremap <leader>q gggqG<C-O><C-O>
" map leader-ev to open .vimrc in a new Vert split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" map leader-eb to open .bashrc in a new vert split
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
" map leader-f to open .zshrc in vsplit 
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
" map leader-f to open netrw/file broswer in vsplit 
nnoremap <leader>f :Vex<cr>

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

" map .. to go up one tree level in fugitive git browsing
" this is from vimcasts...but I can't currently get it to work
" the mapping itself will work, but the conditional doesn't 
" seem to evalutate to true
" probably fugitive's implemenation has changed too much since the vimcast
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\(fugitive)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
    " set previewheight window to 15, as for Gstatus
    set previewheight=15


" autoclean fugitive objects from buffers
" thanks to vim casts / Drew Neil
autocmd BufReadPost fugitive://* set bufhidden=delete

" allows buffer to be hidden if you've modified the buffer
set hidden

" turn on smart indent and autoindent
set si ai

" text display options; window wrap, linebreak, textwidth
set wrap linebreak tw=80

" turn on underline
set cursorline

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
colorscheme morning
au FileType markdown colorscheme murphy

" highlight serarch results
set hlsearch
" start matching pattern while typing
set incsearch

" search highlighting colours
hi Search ctermfg=green ctermbg=red

" air-line
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

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

" execute folding everytime a file is opened (only rly needed when opening file
" w netrw)
au FileType * setlocal foldtext=MyFoldText()
