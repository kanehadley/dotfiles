setlocal shiftwidth=4 tabstop=4
set t_Co=256
syntax on
set background=dark
set expandtab
au BufNewFile,BufRead *.nf set filetype=nextflow

autocmd FileType html setlocal shiftwidth=2 tabstop=2 foldmethod=indent
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 foldmethod=indent
autocmd FileType python setlocal shiftwidth=4 tabstop=4 foldmethod=indent
autocmd FileType ml setlocal shiftwidth=4 tabstop=4 foldmethod=indent
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 foldmethod=indent
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 foldmethod=indent
autocmd FileType nextflow setlocal shiftwidth=2 tabstop=2 foldmethod=indent
autocmd FileType json setlocal shiftwidth=2 tabstop=2 foldmethod=indent
autocmd FileType clojure setlocal shiftwidth=2 tabstop=2 foldmethod=indent
set foldmethod=syntax
set foldlevel=99
set number
set visualbell
nmap <leader> :set list!<CR>
set list

set colorcolumn=80