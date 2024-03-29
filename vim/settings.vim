set updatetime=500          "set time before screen is updated
set path+=**                "append project root and subdirs to path 
set wildmenu                "turn on the autocomplete menu
set ignorecase              "ignore case in searches, unless ...
set smartcase               " ...there are caps in the search string
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab   "tab key indent 4 spaces
set foldmethod=indent       "use manual folding
set foldlevelstart=1        "set default foldlevel to 1
set number                  "enable line numbering
set relativenumber          "relative line numbering
set hidden                  "allows buffer to be hidden if modified
set nosmartindent noautoindent  "smart indent and autoindent
set autochdir               "change pwd when opening a file
" set noautochdir             "dont' change pwd when opening a file
"                             " changing makes project navigation harder
set wrap linebreak tw=80    "window wrap, linebreak, textwidth
""set breakindent             "indent multi-line wrapped lines

" note that light themes don't work well if xresources not using a light theme
colorscheme default
set background=dark

set nocursorcolumn
set cursorline
highlight clear SignColumn|                          "don't highlight the git gutter or Cursorline
highlight Search ctermfg=green ctermbg=red|          "search highlighting colours

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" add parent dir for tags
set tags+=../tags

"set statusline=%t\ [%n]\ (%F)\ %{fugitive#statusline()[4:-2]}\ %h%w%m%r%y%=%-16(\ %l,%c-%v\ %)%P  "apapted from tpope
" set statusline=[%n]\ %<%.99f\ %{fugitive#statusline()[4:-2]}\ %h%w%m%r%y%=%-16(\ %l,%c-%v\ %)%P  "apapted from tpope
set laststatus=2            "always show statusline
set showcmd                 "show command while typing it
set term=$TERM
set term=xterm-256color
set t_Co=256                "set terminal to 256 colors
set hlsearch                "highlight serarch results
set termguicolors           "enable support for truecolor
set incsearch               "start matching pattern while typing
set foldtext=MyFoldText()   "fold text from fn
set previewheight=15        "quickfix height
set re=1                    "use old regex engine; better w ruby
set list                    "enable listchars
set formatoptions=1ntqr     "specify auto-format options - default tqlnr"
let mapleader=','           "use comma as leader key
let g:gitgutter_override_sign_column_highlight = 1           "tell git-gutter to leave sign column alone
let g:limelight_conceal_ctermfg = 'gray'                     "set limelight dim color
" let g:ycm_server_python_interpreter = '/usr/bin/python2'   "set youcompleteme interpreter
" let g:ycm_seed_identifiers_with_syntax = 1
" exec "set listchars=tab:\uBB\uBB,nbsp:~,trail:\u2022"       
exec "set listchars=tab:>-,nbsp:~,trail:\u2022"       
        
"syntax folding
let javaScript_fold=1       "JavaScript
let php_folding=1           "PHP
let ruby_fold=1             "Ruby
let sh_fold_enabled=1       "sh
let vimsyn_folding='af'     "Vim script
let xml_syntax_folding=1    "XML

"autocompletion
set complete=.,b,u,]
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

"netrw
" trying to fix an issue with orphan netrw issues
" see https://github.com/tpope/vim-vinegar/issues/13
let g:netrw_liststyle=3     "show netrw split in tree style
"let g:netrw_banner=0        "hide the netrw shortcut banner
let g:netrw_winsize=25      "set split width to 25%
let g:netrw_browse_split=4  "when opening a file, show it in previous pane
let g:netrw_altv=1          "shows browser pane on left (I think)
let g:netrw_fastbrowse = 0

" NERDTree (sorry netrw)
let NERDTreeShowHidden = 1

" latex helpers; specifically vimtex plugin options
let g:vimtex_view_method = 'mupdf'
let g:livepreview_previewer = 'mupdf'
let g:vimtex_quickfix_latexlog = { 'overfull' : 0}
"let g:vimtex_view_forward_search_on_start = 1
"
" ultisnips
" let g:UltiSnipsExpandTrigger="<c-tab>"            "shift-tab has stopped working for some reason (sept 25, 2018)
let g:UltiSnipsExpandTrigger="<s-tab>"            "shift-tab has stopped working for some reason (sept 25, 2018)
let g:UltiSnipsJumpForwardTrigger="<c-j>"       "move to next field
let g:UltiSnipsJumpBackwardTrigger="<c-k>"      "move to previous field
let g:UltiSnipsSnippetDirectories=['/home/km/config_files/vim/UltiSnips/']    "use custom dir for snippets
"
" let g:UltiSnipsSnippetsDir        = $HOME.'/.vim/UltiSnips/'
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsListSnippets="<c-h>"

" let g:ycm_complete_in_comments = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
"
"ctrlp
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_use_caching = 1|                    "cache filelist
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'|  "store cache in home
let g:ctrlp_clear_cache_on_exit = 0|            "clear cache
let g:ctrlp_follow_symlinks=1|
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s --hidden --nocolor -l -g ""'   "use ag as search command
endif

"ESlint and ALE settings"
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = 'N'
let g:ale_sign_warning = 'O'
let g:ale_fix_on_save = 1

" Jedi-vim"
let g:jedi#completions_command = "<C-N>"             "use ctrl-n to trigger autocompletion in jedi-vim
