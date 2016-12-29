" append project root dir and subdirs to path when opening vim
set path+=**

" modify tabcomplete - insert longest common text
" set completeopt=longest,menuone "somewhat unclear about func here
" set wildmode=longest,full
set wildmenu

" netrw tree view, banner, winsize
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize= 25 
let g:netrw_browse_split=4
let g:netrw_altv = 1
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" turn on line numbering
set number relativenumber

" auto insert eruby tags
imap <% <%= %><left><left>

" auto insert html tags
imap <p <p><ENTER></p><up>

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
