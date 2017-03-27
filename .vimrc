" note - add a <%=  %> wrapper for change surround
" Plug - auto install if not present
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

"Plug functionality, load the plugings at runtime
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'vim-scripts/xmledit'
Plug 'vim-airline/vim-airline'
"need to simlink to /.vim/plugged/xmledit/ftplugin, ln -s xml.vim html.vim
Plug 'vim-scripts/AutoClose'
call plug#end()

" append project root dir and subdirs to path when opening vim
" this is useful for filename completion
set path+=**

" turn on the autocomplete menu
set wildmenu

" do case sensitive searching if any caps in search string
set ignorecase
set smartcase

" show tabs, spaces, and trailing spaces
set listchars=tab:>~,nbsp:_,trail:.
set list

"remap leader to comma ","
let mapleader=","

"use cold folding, syntax-wise
set foldmethod=syntax

"set default foldlevel to 1
set foldlevelstart=1
" use spacebar to toggle folding
nnoremap <Space> za

" use tab to jump out of closures (quotes, brackets, etc)
" thanks to Ingo Karkat
"inoremap <expr> <Tab> search('\%#[]>)}''"]', 'n') ? '<Right>' : '<Tab>'

" netrw tree view, banner, winsize
" show netrw split in tree style"
let g:netrw_liststyle=3
" hide the netrw shortcut banner
let g:netrw_banner=0
" set split width to 25%
let g:netrw_winsize= 25 
" when opening a file, show it in previous pane
let g:netrw_browse_split=4
" shows browser pane on left (I think)
let g:netrw_altv = 1
" project drawer view as default when opening vim
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" turn on line numbering
set number relativenumber

"SNIPPETS

" auto insert eruby tags
imap <% <%=  %><left><left><left>

" auto insert href structure
imap <a<space>h <a<space>href="http://www..com/"><esc>2bhi

" auto complete the def/end typing in ruby files
au FileType ruby,eruby imap def<space> def<cr>end<up> 

"Read an empty HTML template and move curosr to title field
"thanks to mcantor
nnoremap <leader>html :-1read ~/.vim/.skeleton.html<CR>3jwf>a

" remap semi-colon and colon in normal mode
nnoremap ; :
nnoremap : ;

" turn on smart indent
set si

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
au FileType php				setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby		setl ofu=rubycomplete#Complete
au FileType html,xhtml		setl ofu=htmlcomplete#CompleteTags
au FileType css				setl ofu=csscomplete#CompleteCSS

set laststatus=2

" show command while typing it
set showcmd

"map leader-ev to open .vimrc in a new Vert split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"map leader-bs to open .bashrc in a new vert split
nnoremap <leader>bs :vsplit ~/.bashrc<cr>

"map leader-f to open netrw in vsplit 
nnoremap <leader>f :Vex<cr>

" set vim to dark background
set t_Co=256
colorscheme industry

" highlight serarch results
set hlsearch

"search highlighting colours
hi Search ctermfg=green ctermbg=red

set foldtext=MyFoldText() 
function! MyFoldText()
    let nblines = v:foldend - v:foldstart + 1
    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0) - 6
    let line = getline(v:foldstart)
    let comment = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    let expansionString = repeat(".", w - strwidth(nblines.comment.'"'))
    let txt = '"' . comment . expansionString . nblines . " lines"
    return txt
endfunction





"execute folding everytime a file is opened (only rly needed when opening file
"w netrw)"
au FileType * setlocal foldtext=MyFoldText()
