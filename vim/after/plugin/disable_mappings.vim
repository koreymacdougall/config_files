" execute after plugins have been loadedr

" these mappings are set by the gutter plugin, 
" and make <leader>h unusable
" i want <leader>h for buffer navigation
" nunmap <leader>hp
" nunmap <leader>hr
" nunmap <leader>hu
" nunmap <leader>hs

" autoclose plugin makes right brackets jump out of current bracket
" makes it very annoying to add brackets inline
iunmap )
iunmap ]
iunmap }
