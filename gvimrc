" alan
" 自訂縮排(Tab)位元數。
set tabstop=2
set shiftwidth=2
set expandtab
set guifont=Monaco:h14
set number

" auto reload vimrc
autocmd BufWritePost $MYVIMRC source $MYVIMRC

nnoremap <F5> :GundoToggle<CR>
