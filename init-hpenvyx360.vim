" Plugins
call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-k>"
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug '7erra/vim-sqf'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'kien/ctrlp.vim'
let g:ctrlp_follow_symlinks=1
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
if has('win32')
	Plug 'ycm-core/YouCompleteMe'
	let g:ycm_seed_identifiers_with_syntax = 1
	let g:ycm_show_diagnostics_ui = 0
endif
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jremmen/vim-ripgrep'
let g:rg_command="rg --follow --vimgrep"
Plug 'dzeban/vim-log-syntax'
au BufNewFile,BufRead *.rpt set filetype=log
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['haskell', 'c', 'python', 'cpp']}
Plug 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
Plug 'haskell/stylish-haskell'
Plug 'thinca/vim-localrc'
let g:localrc_filename='.local.vimrc'
Plug 'mpickering/hlint-refactor-vim', {'for': ['haskell']}
call plug#end()

" Settings
colorscheme onedark
set langmenu=en_US.UTF-8
language en_US.UTF-8
filetype plugin on
hi! link netrwMarkFile Search

" Variables
if has('win32')
	let g:python3_host_prog = '~\AppData\Local\Programs\Python\Python310\python.exe'
	let &shell = has('win32') ? 'pwsh' : 'pwsh'
	let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
	let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	set shellquote= shellxquote=
	" au FileType c let &makeprg="gcc % -o ./build/" . expand("%:t:r") . ".exe"
	if has('nvim')
		let g:session_directory=stdpath("data")."\\sessions"
	endif
	let g:netrw_rmdir_cmd="rm -Recurse"
	let g:netrw_rmf_cmd="rm -Recurse -Force"
else
	let g:python3_host_prog = '/usr/bin/python3'
endif
let g:session_autoload=0
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
let g:ack_use_cword_for_empty_search = 1
let g:netrw_altv=1
let g:arma3_dir = 'D:\\SteamLibrary\\steamapps\\common\\Arma 3'
let g:netrw_banner=0
" let g:netrw_browse_split=4
" let g:netrw_liststyle=3

set tabstop=4
set shiftwidth=2
set expandtab
set smartindent
set colorcolumn=81
set number
set ignorecase
set smartcase
set list
set listchars=tab:>-,space:·,trail:~
set splitbelow
set guioptions-=e
let mapleader="ß"
set fdm=indent
set foldlevelstart=20
set belloff=all
autocmd BufRead,BufNewFile */Nextcloud/Documents/os/** set makeprg=gcc\ %\ -o\ %:r\ -Wall\ -Werror

" Commands
command! Rpt execute "silent !cmd.exe /c start powershell -c Rpt-Watch"
if has('nvim')
	autocmd TermClose exe 'bdelete! ' ..expand('<abuf>')
	command! DelTerms :bd! term*
	command! NewTerminal bo split<bar>exe ":terminal"<bar>res 10<CR>setl wfh<CR>
endif
command! CopyFilepath let @+ = expand("%")
command! CmakeInit !cmake -S . -B .\build\ -G "MinGW Makefiles"
command! Fix execute "YcmCompleter FixIt"
" Create netrw window at the very left like in an IDE
command! FileTree topleft vs . <bar> vert res 30 <bar> setl wfw
command! Ide exec "NewTerminal" <bar> Explorer

" Keybindings
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

inoremap <C-V> <C-R>+
nmap <C-s> :update<CR>
" inoremap <expr><TAB> pumvisible() ? '\<C-n>' : '\<TAB>'
call SetupCommandAlias("os", "OpenSession")
nnoremap <leader>os :OpenSession 
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <leader>c <C-\><C-n>
tnoremap <leader>w <C-\><C-n><C-W>w
tnoremap <C-k> <Up>
tnoremap <C-j> <Down>
tnoremap <C-c> <C-\><C-n>
tnoremap <C-C> <C-c>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
nnoremap <leader>t :NewTerminal<CR>
augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost l* lwindow
augroup END
nnoremap <silent> <leader>Q :cprevious<CR>
nnoremap <silent> <leader>q :cnext<CR>
nmap <c-f> :Rg<space>
nnoremap <c-.> @:
nmap <leader>a gg0vG$
cmap <C-k> <Up>
cmap <C-j> <Down>
nnoremap <leader>g :YcmCompleter GoToDefinition<CR>
inoremap ´´ ´<space><bs>
nnoremap <leader>e :Explorer<CR>
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" inoremap <silent><expr> <Tab>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
nnoremap <C-w>d :vertical resize<CR>
nnoremap <C-w>w :resize<CR>
map j gj
map k gk
