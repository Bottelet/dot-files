call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'tpope/vim-sensible' " Defaults
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' } " Theme
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-startify'
Plug 'mg979/vim-localhistory'
Plug 'mbbill/undotree'
" Undo Tree same as ^ on steroids but uses Python
"Plug 'simnalamburt/vim-mundo'

"Snipmate dependencies
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'nathanaelkane/vim-indent-guides'
"Optional Snipmate dependency
Plug 'honza/vim-snippets'

Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'

call plug#end()
set rtp+=~/.fzf

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set nocompatible   " Disable vi-compatibility
set t_Co=256
syntax on
set cursorline
let g:airline_theme='onehalfdark'
colorscheme onehalfdark

" lightline
let g:lightline = {
            \ 'colorscheme': 'onehalfdark',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ]
            \ },
            \}
set guifont=menlo\ for\ powerline:h16
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set linespace=15
set laststatus=2
set hidden
set history=500
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set smarttab
set tags=tags
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set timeout timeoutlen=400 ttimeoutlen=200
set visualbell           " don't beep
set noerrorbells         " don't beep
set clipboard=unnamedplus
set autowrite  "Save on buffer switch
set mouse=a

let mapleader = ","

" Down is really the next line
nnoremap j gj
nnoremap k gk

"Easy escaping to normal model
imap jj <esc>

"easier window navigation

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap vs :vsplit<cr>
nmap sp :split<cr>

" qq to record, Q to replay
nnoremap Q @q

" Swap files out of the project root
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

autocmd cursorhold * set nohlsearch
autocmd cursormoved * set hlsearch

map <leader>s :noh<CR>
map <leader>so :source ~/.vimrc<CR>
map <leader>ev :e ~/.vimrc<CR>

" term
" vim-powered terminal in split window
map <Leader>vt :vert bo term ++close<cr>
map <Leader>st :term ++close<cr>
tmap <Leader>st <c-w>:term ++close<cr>

" vim-powered terminal in new tab
map <Leader>T :tab term ++close<cr>
tmap <Leader>T <c-w>:tab term ++close<cr>

" Only doing left and right, else FZF gets messed up on file selection
"tnoremap <C-J> <C-W><C-J>
"tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

"map <leader>f :FZF<CR>
map <C-f> :Rg<CR>
nnoremap <silent> <C-p> :Files<CR>
map <leader>f :FZF<CR>

nmap <silent> <leader>h :History<CR>

"NERDTree actions
map <leader>1 :NERDTreeToggle<CR>
map <leader>2 :NERDTreeFind<CR>

let g:fzf_filemru_bufwrite = 1
let g:fzf_filemru_git_ls = 1
let g:fzf_filemru_ignore_submodule = 1
let g:fzf_layout = { 'down': '25%' }

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Allow for tab and shift tab to move in suggestions list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>r  <Plug>(coc-format-selected)
nmap <leader>r  <Plug>(coc-format-selected)

" Git fugitive
nmap <leader>gb :Git blame<cr>
nmap <leader>gs :Git status<cr>
nmap <leader>gd :Git diff<cr>
nmap <leader>gc :Git commit<cr>

" Nerdcommenter
nnoremap <leader>cc V}:call nerdcommenter#Comment('x', 'toggle')<CR>
nnoremap <leader>c<space> V}:call nerdcommenter#Comment('x', 'comment')<CR>
"https://github.com/preservim/nerdcommenter#default-mappings

"Synstaic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Show list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"icons
let g:syntastic_error_symbol = '✖'
let g:syntastic_style_error_symbol = '✖'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_warning_symbol = '!'
let g:syntastic_enable_highlighting = 1

"Snipmate
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

"Multi cursor
"<ctrl>n
"https://github.com/mg979/vim-visual-multi/wiki/Quick-start

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"Silent mode with Vim-zenroom2 and Goyo
nnoremap <silent> <leader>z :Goyo<cr>
let g:goyo_width=180
"https://github.com/amix/vim-zenroom2
"
let g:snipMate = { 'snippet_version' : 1 }

"Startify
let g:startify_custom_footer =
           \ ["Me: Will you be my Valentine", "Girl: No way!", "Me: sudo Will you be my Valentine", "Girl: yes..yes..yes! Let's go"]
let g:startify_bookmarks = [
            \ { 'v': '~/.vimrc' },
            \ { 'z': '~/.zshrc' },
            \ { 'a': '~/.dotfiles/shell/.aliases' },
            \ { 'f': '~/.dotfiles/shell/.functions' },
            \ { 'c': '~/.dotfiles-custom/shell/.zshrc' },
            \ { 'g': '~/.gitconfig' },
            \ ]
let g:startify_enable_special      = 0
let g:startify_files_number        = 8
let g:startify_relative_path       = 0
let g:startify_change_to_dir       = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1

" UndoTreeToggle
nnoremap <silent> <leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" MundoToggle
"set undofile
"set undodir=~/.undodir
"nnoremap <silent> <leader>u :MundoToggle<CR>

" Local history
let g:lh_basedir = '~/.vim_history'
" <leader> + prefix in use
" + l = load backups
" + b = browse backups
" + w = write backups
" + d = select backup and diff
" + x = delete backup for current dir
let g:lh_mappings_prefix = 'gh'
let g:lh_autobackup_first = 1
let g:lh_autobackup_size  = 51200
let g:lh_autobackup_frequency = 1

" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------
command! Chomp %s/\s\+$// | normal! ``

" ----------------------------------------------------------------------------
" :Count
" ----------------------------------------------------------------------------
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

" ----------------------------------------------------------------------------
" call LSD()
" ----------------------------------------------------------------------------
function! LSD()
  syntax clear

  for i in range(16, 255)
    execute printf('highlight LSD%s ctermfg=%s', i - 16, i)
  endfor

  let block = 4
  for l in range(1, line('$'))
    let c = 1
    let max = len(getline(l))
    while c < max
      let stride = 4 + reltime()[1] % 8
      execute printf('syntax region lsd%s_%s start=/\%%%sl\%%%sc/ end=/\%%%sl\%%%sc/ contains=ALL', l, c, l, c, l, min([c + stride, max]))
      let rand = abs(reltime()[1] % (256 - 16))
      execute printf('hi def link lsd%s_%s LSD%s', l, c, rand)
      let c += stride
    endwhile
  endfor
endfunction

