" vim:fdm=marker

" General Settings {{{

" Use Vim settings, rather than Vi settings
set nocompatible

" Set up Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
filetype off
call pathogen#infect()
call pathogen#helptags()

" Enable file type detection/syntax highlighting
filetype plugin indent on
syntax enable

" No Vim-generated files
set nobackup

" Keeps buffers open in the background
set hidden

" Keep 100 lines of command line history
set history=100

" When vertically splitting, new pane is on the right
set splitright

" Adjust the tab size
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Turn on auto-ident
set autoindent
set smartindent

set hlsearch   " Highlight searches
set incsearch  " Highlight dynamically as pattern is typed
set ignorecase " Make searches case-insensitive...
set smartcase  " ...unless they contain at least one uppercase character
set gdefault   " Use global search by default

" Improve graphics response in some terminals
set ttyfast

" Update syntax highlighting for more lines increased scrolling performance
syntax sync minlines=256

" Don't syntax highlight long lines, better performance
set synmaxcol=256

" Auto-read file if it has been edited externally
set autoread

" Change the .md extension to Markdown
autocmd BufRead,BufNew *.md set filetype=markdown

" Associate *.vstxml with XML syntax
autocmd BufRead,BufNew *.vstxml set filetype=xml

" Enable wildmenu for better autocompletion
set wildmenu

" When viewing directories, show nested tree mode
let g:netrw_liststyle=3

" Don't create .netrwhist files
let g:netrw_dirhistmax = 0

" }}}
" Key Bindings {{{

" Rebind leader key to spacebar
let mapleader=" "

" Bind Leader-y, yy, p, and P to clipboard register
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p "*p
noremap <leader>P "*P

" Bind increment/decrement to Leader, due to tmux prefix
noremap <leader>a <C-a>
noremap <leader>x <C-x>

" Rebind arrow keys for buffer and window movement
noremap <Up> :BufstopFast<CR>
"noremap <Down> :bp <BAR> bd #<CR>
noremap <Left> :bprevious<CR>
noremap <Right> :bnext<CR>
noremap <Leader>k <C-w>k
noremap <Leader>j <C-w>j
noremap <Leader>h <C-w>h
noremap <Leader>l <C-w>l

" Leader-b opens the buffer list, prompts for which buffer to open
" :map <leader>b :ls<CR>:b

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Enter will clear search highlighting
noremap <CR> :noh<CR>

" Disable the annoying help function on <F1>
nmap <F1> <nop>

" }}}
" Visual + Colorscheme {{{

" Set colorscheme
set t_Co=256
set background=dark
colorscheme gruvbox

" Hide the scrollbars in MacVim
set guioptions-=L
set guioptions-=R

" Restore test-based tab bar in MacVim
set guioptions-=e

" Set the font to something pretty 
set guifont=Monaco\ for\ Powerline:h12

" Always display statusline
set laststatus=2

" This is the old statusline code I wrote, uncomment if need be
" set statusline=%F%m\ %r%h%w\ \|\ \ [%{&ff}:%Y]\ %=[%04l,%04v]\ [%p%%]
" au InsertEnter * hi StatusLine term=reverse ctermfg=62 gui=undercurl guisp=Green
" au InsertLeave * hi StatusLine term=reverse ctermfg=238 ctermbg=253 gui=bold,reverse

" Offset the screen while scrolling to keep the cursor centered
set scrolloff=999

" Turn on visual bells
set visualbell
set errorbells

" Show the cursor position all the time
set ruler

" Display incomplete commands
set showcmd

" Display line numbers by default
set number

" Set line numbers to be relative to current line location
set relativenumber

" Turn on intelligent word wrapping
set wrap linebreak nolist

" Display spaces before EOL as squares, hard tabs as arrows
set listchars=trail:□,tab:→\ 

" }}}
" Lightline {{{

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \	'left': [ [ 'mode', 'paste' ],
    \		  [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \	'fugitive': 'MyFugitive',
    \	'filename': 'MyFilename',
    \	'modified': 'MyModified',
    \	'readonly': 'MyReadonly',
    \ },
    \ }

    "\ 'separator': { 'right': '', 'left': '' },
    "\ 'subseparator': { 'right': '', 'left': '' }

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

" Fix lightline.vim's insert mode display delay
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" }}}
" Vim-Startify {{{

" guifg=base00 
hi default link StartifyHeader Number 
autocmd FileType startify setlocal buftype=

let g:startify_custom_header = [
                \ '   __  __                        ________  __ __      ',
                \ '  /\ \/\ \  __                  /\_____  \/\ \\ \     ',
                \ '  \ \ \ \ \/\_\    ___ ___      \/___// / \ \ \\ \    ',
                \ '   \ \ \ \ \/\ \ /  __` __`\        /  /   \ \ \\ \_  ',
                \ '    \ \ \_/ \ \ \/\ \/\ \/\ \      /  / __  \ \__  __\',
                \ '     \ `\___/\ \_\ \_\ \_\ \_\    /\_/ /\_\  \/_/\_\_/',
                \ '      `\/__/  \/_/\/_/\/_/\/_/    \//  \/_/     \/_/  ',
                \ '',
                \ ''
                \ ]
let g:startify_custom_footer = ['',''] + map(split(system('fortune'), '\n'), '"   ". v:val')

" }}}
" Vim-markdown {{{

" Enable syntax highlighting for fenced code blocks
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'scala', 'ruby', 'clojure']

" }}}
" Python-mode {{{

" Disable linting to be compatible with Syntastic
let g:pymode_lint = 0

" Disable the annoying fold default
let g:pymode_folding = 0
" }}}
" Bufstop {{{

" Leader-b to open buffer list
noremap <leader>b :BufstopFast<CR>

" }}}
" Goyo {{{

" Leader-g to enable Goyo
map <leader>g :Goyo

" Change default width to identify wrapping > 80
let g:goyo_width=90

" }}}
" RIV {{{

" Turn off the annoying folds
let g:riv_disable_folding=1

" }}}
" Bufkill {{{

" Replace bd, bun, bw with Bufkill
cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD' : 'bdelete')<CR>
cabbrev bun <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BUN' : 'bunload')<CR>
cabbrev bw <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BW' : 'bwipeout')<CR>

" }}}
" glsl.vim {{{

" Add *.frag and *.vert as file extensions
let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.frag,*.vert'

" }}}

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
