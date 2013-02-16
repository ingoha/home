
set hlsearch
set incsearch
set expandtab
set autoindent
set smartindent
set textwidth=0
set number
set scrolljump=5
set scrolloff=3
set tabstop=4
set shiftwidth=4
set showmode
set ruler
set showmatch
syntax on

";r runs the current file from php
map ;R :let g:last_php_file=expand("%:p")<CR>:!clear ; nodejs %:p<CR>
";R runs the last ran file from php
map ;r :exec '!clear ; nodejs ' g:last_php_file<CR>
";l lint checks the current file through php
map ;l :!clear ; nodejs %:p<CR>
";p toggles paste modes
map <silent> ;p :let &paste = &paste == 1 ? 0 : 1<CR>:echo 'paste ' . ( &paste == 1 ? 'ON' : 'OFF' )<CR>
";h turns off highlighting
map ;h :noh<CR>

",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
map ,v :sp ~/.vimrc<CR><C-W>_
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
