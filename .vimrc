set fileformat=unix " number of columns a tab counts for (when reading a file)
set tabstop=4
" how many columns to use when hitting TAB in insert mode
set softtabstop=4
" used for << >> indent operators
set shiftwidth=4
" expandtab inserts spaces instead of tabs
" set expandtab
colorscheme vividchalk 
set number

let g:user_zen_leader_key = '<c-k>'
nnoremap <F5> :buffers<CR>:buffer<Space>

syntax on

"code folding 
set foldmethod=indent
set nofoldenable

"filetype plugin on
let processing_doc_path="c:\\Programs\\Processing\\reference"
