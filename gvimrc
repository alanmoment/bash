" alan
" 自訂縮排(Tab)位元數。
set tabstop=4  
set shiftwidth=4  
set softtabstop=4  
set expandtab  
set smarttab

"设置Tab键跟行尾符显示出来  
set list lcs=tab:>-,trail:-

"开启自带的tab栏  
set showtabline=2

set guifont=Monaco:h14
set number
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" auto reload vimrc
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby

nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :NERDTreeToggle<CR>
" r:refresh folder; R: refresh root folder
