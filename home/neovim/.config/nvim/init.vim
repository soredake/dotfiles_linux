set mouse=a             " enable mouse
set number              " show line numbers
set cursorline          " highlight current line
set list                " http://www.chrispian.com/quick-vi-tip-show-hidden-characters/
set listchars=tab:▸\ ,eol:¬  " https://git.sr.ht/~sircmpwn/dotfiles/tree/.vimrc#n122

" https://neovim.io/doc/user/provider.html#provider-clipboard
set clipboard+=unnamedplus

" load plugins from portage
let &runtimepath.=',/usr/share/vim/vimfiles/'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
" %* is black background
" 2nd is default statusline https://neovim.io/doc/user/options.html#%27statusline%27
set statusline+=%*
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
