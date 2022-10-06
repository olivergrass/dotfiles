" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
  " \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:which_key_map = {}
let g:which_key_map['/'] = [ ':Commentary'                , 'comment' ]
let g:which_key_map['v'] = [ ':NvimTreeToggle'            , 'open NvimTree' ]
let g:which_key_map['S'] = [ ':Alpha'                     , 'start screen' ]
let g:which_key_map['t'] = [ ':Telescope live_grep'       , 'search text' ]
let g:which_key_map['f'] = [ ':Telescope find_files'      , 'search files' ]
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5' , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5' , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ }
let g:which_key_map.s = {
      \ 'name' : '+search'     ,
      \ 'b' : [':Telescope git_branches'        , 'Checkout branch']   ,
      \ 'f' : [':Telescope find_files'          , 'Find File']         ,
      \ 'r' : [':Telescope oldfiles'            , 'Open Recent File']  ,
      \ 't' : [':Telescope live_grep'           , 'Text']              ,
      \ }
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ }
let g:which_key_map.p = {
      \ 'name' : '+plug'                        ,
      \ 'i' : [':PlugInstall'                   , 'install'],
      \ 'u' : [':PlugUpdate'                    , 'update'],
      \ 'c' : [':PlugClean'                     , 'clean'],
      \ 's' : [':source ~/.config/nvim/init.vim', 'source vimrc'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
