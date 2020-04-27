" note the bar at the end of each mapping, just to allow inline comments
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL Mappings"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ; :|                                                                        "remap semi-colon to colon
nnoremap : ;|                                                                        "remap colon to semi-colon
nnoremap <CR> :nohlsearch<CR>|                                                       "use enter to clear search hl
nnoremap Y y$|                                                                       "Y to behave as D and C do
nnoremap <c-n> :%s///g<left><left>|                                                  "use ctrl-n to replace all star-searched terms
nnoremap <space> za|                                                                 "use spacebar to toggle folding
nnoremap <leader><leader> z=i1<cr><cr>|                                              "quick spell check; take first suggestion
nnoremap <leader>d :read ! date --iso-8601<cr>|                                      "insert date YYYY-MM-DD
nnoremap <leader>p :%s/print(/#print(/<CR>|                                          "comment out all python ##print statements
nnoremap <leader>P :%s/#print(/print(/<CR>|                                          "uncomment all prints
nnoremap <leader>ns :r !notmuch search|                                              "notmuchsearch
nnoremap <leader>nn 0 qnq "nyiW :new \| r ! notmuch show <C-r>n<CR>gg4jzt|           "notmuch show
nnoremap <leader>cc :set cursorcolumn! cursorline! <CR>|                             "cursorcolumn
nnoremap <leader>nh :nohlsearch<CR>|                                                 "turn off search highlight
nnoremap <leader>f :Vex<cr>|                                                         "open netrw/file broswer in vsplit 
nnoremap <buffer> <leader>u :edit %:h<CR>|                                           "move up one level in fugitive
nnoremap <leader>tm :TableModeToggle<CR>|                                            "toggle tablemode plugin
nnoremap <leader>rw :%s/\s\+$//e<CR>|                                                     "clear trailing whitespace
nnoremap <leader>t :! rails test<CR>|                                                "run test suite
nnoremap <leader>gg :setl nosmd nosc nocul nocuc nosi nolist <cr>|                   "disable displays for writing"
nnoremap <leader>GG :setl smd sc cul cuc si list<cr>|                                "reenable displays"
nnoremap <leader>!p :!python3 %<cr>|                                                     "shell out to run this program in python3
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>                  "change pwd and print

"-- seeing is believing commands
"-- run seeing_is_ believing on current buffer
nnoremap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
"-- clear seeing is believing in current buffer
nnoremap <leader>c :%.!seeing_is_believing --clean<CR>;

"--quick file editing
nnoremap <leader>ev :e $MYVIMRC<cr>|                                                 "edit vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>|                                            "source vimrc
nnoremap <leader>eb :e ~/.bashrc<cr>|                                                "edit bashrc
nnoremap <leader>ez :e ~/.zshrc<cr>|                                                 "edit zshrc
nnoremap <leader>ec :e ~/config_files/notes/cheatsheet.md<cr>|                       "edit cheat.sheet
nnoremap <leader>em :e ~/mail_configs/.muttrc<cr>|                                   "edit muttrc
nnoremap <leader>ei :e ~/config_files/i3/i3_config<cr>|                              "edit i3 config
nnoremap <leader>et :e ~/config_files/.tmux.conf<cr>|                                "edit tmux config
nnoremap <leader>en :e ~/notes.md<cr>|                                               "edit notes file
nnoremap <leader>es :UltiSnipsEdit<CR>|                                              "edit snippets file
nnoremap <leader>eq :e ~/config_files/quotes.md<CR>|                                 "edit quotes file
nnoremap <leader>ex :e ~/config_files/.Xresources<CR>|                               "edit quotes file

nnoremap <leader>sl :set background=light\|colorscheme solarized<CR>|              "enable solarized light

"--buffer navigation
nnoremap <leader>l :bnext<cr>|                                                       "move to the next buffer
nnoremap <leader>h :bprevious<cr>|                                                   "move to the previous buffer

"--ctrl=-
nnoremap <c-p> ::CtrlPMixed<cr>|                                                     "open ctrl-p in mixed mode, search Files/Buffers/MRU files 
" note: MRU = most recently used

"--navigate quickfix list,; also found in tpope's unimpaired
nnoremap [q :cprevious<CR>|                                                          "previous quickfix item
nnoremap ]q :cnext<CR>|                                                              "next quickfix item
nnoremap [Q :cfirst<CR>|                                                             "first quickfix item
nnoremap ]Q :clast<CR>|                                                              "last quickfix item
"--resize splits; thanks to Andy Wokula
"--SID appears to be a unique script ID?  an appended var? 
nmap        <C-W>+     <C-W>+<SID>winheight
nmap        <C-W>-     <C-W>-<SID>winheight
nmap        <C-W>>     <C-W>><SID>winwidth
nmap        <C-W><     <C-W><<SID>winwidth
nnoremap    <script>   <SID>winheight+   <C-W>+<SID>winheight
nnoremap    <script>   <SID>winheight-   <C-W>-<SID>winheight
nnoremap    <script>   <SID>winwidth>    <C-W>><SID>winwidth
nnoremap    <script>   <SID>winwidth<    <C-W><<SID>winwidth
nmap         <SID>winheight     <Nop>|                                               "<Nop> is no action, so these ...
nmap         <SID>winwidth      <Nop>|                                               "... disable the mappings from firing too soon
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"VISUAL MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap . :normal .<CR>|                                                            "dot repeat for visual selection
vnoremap * y/<C-R>"<CR>|                                                             "use asterisk searching in visual mode
vnoremap ; :|                                                                        "remap semi-colon to colon
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"INSERT MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <Tab> search('\%#[]>)}''"]', 'n') ? '<Right>' : '<Tab>'|               "tab out of closures; thanks to Ingo Karkat
inoremap <C-d> <esc>:let @x = system('date --iso-8601 \| xargs echo -n ')<cr>i <C-r>x| "insert date inline
inoremap <C-t> <esc>:let @x = system('date +"%H:%M" \| xargs echo -n ')<cr>i <C-r>x| "insert time inline
