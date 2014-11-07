" alan
" 自訂縮排(Tab)位元數。
set tabstop=4
set shiftwidth=4
set expandtab
set guifont=Monaco:h14

" auto reload vimrc
autocmd BufWritePost $MYVIMRC source $MYVIMRC

nnoremap <F5> :GundoToggle<CR>
