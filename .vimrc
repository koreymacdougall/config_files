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
"need to go to /.vim/plugged/xmledit/ftplugin, ln -s xml.vim html.vim
"otherwise, script won't work on html (and erb) files
Plug 'vim-scripts/AutoClose'
call plug#end()

" append project root dir and subdirs to path when opening vim
" this is useful for filename completion
set path+=**

" turn on the autocomplete menu
set wildmenu

" show tabs, spaces, and trailing spaces
set listchars=tab:>~,nbsp:_,trail:.
set list
" netrw tree view, banner, winsize
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize= 25 
let g:netrw_browse_split=4
let g:netrw_altv = 1
" project drawer view as default when opening vim
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" turn on line numbering
set number relativenumber

" auto insert eruby tags
imap <% <%=  %><left><left><left>

" remap semi-colon and colon in normal mode
nnoremap ; :
nnoremap : ;

" turn on smart indent
set si

" text display options; window wrap, linebreak, textwidth
set wrap linebreak tw=80

" set vim to dark background
set background=dark

" set tab key to indent 4 spaces
set tabstop=4 softtabstop=0 shiftwidth=4

" turn on syntax completion - C-x C-o
syntax on
filetype plugin indent on
au FileType php				setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby		setl ofu=rubycomplete#Complete
au FileType html,xhtml		setl ofu=htmlcomplete#CompleteTags
au FileType css				setl ofu=csscomplete#CompleteCSS

" show command while typing it
set showcmd
