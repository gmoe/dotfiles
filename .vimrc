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
set backupcopy=yes

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

" Speed up delay between inputs
set timeoutlen=1000 ttimeoutlen=0

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
" set synmaxcol=256

" Auto-read file if it has been edited externally
set autoread

" Enable wildmenu for better autocompletion
set wildmenu
set wildignorecase

" Hide intro
set shortmess+=I

" }}}
" Filetype Detection {{{

" Turn on spell-check for git commit messages
autocmd BufRead,BufFilePre,BufNew COMMIT_EDITMSG set spell

" Turn on spell-check for markdown files
autocmd BufRead,BufFilePre,BufNew *.md set spell

" Associate *.vstxml with XML syntax
autocmd BufRead,BufFilePre,BufNew *.vstxml set filetype=xml

" View control characters in CSV/TSV files
autocmd BufNewFile,BufRead *.csv set list
autocmd BufNewFile,BufRead *.tsv set list

" See .gitignore as .gitconfig files, not completely accurate but suitable
autocmd BufNewFile,BufRead .gitignore set filetype=gitconfig

" See Brewfiles as Ruby files
autocmd BufNewFile,BufRead *Brewfile* set filetype=ruby

" See any file containing 'Dockerfile' as a dockerfile
autocmd BufNewFile,BufRead *Dockerfile* set filetype=dockerfile

" Support style tags in SVG files
augroup svg_inline_style
  autocmd!
  autocmd BufNewFile,BufRead *.svg syn include @svgCSS syntax/css.vim
  autocmd BufNewFile,BufRead *.svg syn region svgStyleTag matchgroup=xmlTag start=+<style+ contained end=+</style>+ contains=@svgCSS
augroup END

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

" Use jk to navigate keyword autocomplete
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

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

" Linter binding
noremap <Leader>e :call ESLintFileExternal()<cr>
function! ESLintFileExternal()
  if (&ft=='javascript' || &ft=='javascript.jsx' || &ft=='javascriptreact' || &ft=='typescript' || &ft=='typescriptreact')
    let linterBuffType = 'eslint'
    " Recursively find local eslint, otherwise use global binary
    let localESLint = findfile('node_modules/.bin/eslint', '.;')
    if (!empty(localESLint))
      let linter = system(localESLint . " " . bufname("%") . " 2>&1")
    else
      let linter = system("eslint " . bufname("%") . " 2>&1")
    endif
  elseif (&ft=='python')
    let linterBuffType = 'pylint'
    let linter = system("pylint -r n " . bufname("%") . " 2>&1")
  elseif (&ft=='sh')
    let linterBuffType = 'shellcheck'
    let linter = system("shellcheck " . bufname("%") . " 2>&1")
  elseif (&ft=='scss' || &ft=='sass' || &ft=='less' || &ft=='css')
    let linterBuffType = 'stylelint'
    " Recursively find local sass-lint, otherwise use global binary
    let localStylelint = findfile('node_modules/.bin/stylelint', '.;')
    if (!empty(localStylelint))
      let linter = system(localStylelint . " " . bufname("%") . " 2>&1")
    else
      let linter = system("stylelint " . bufname("%") . " 2>&1")
    endif
  endif
  if (exists('linter'))
    split __Linter_Results__
    normal! ggdG
    setlocal buftype=nofile
    setlocal bufhidden=delete
    let &filetype = linterBuffType
    call append(0, split(linter, '\v\n'))
  else
    echo "File type \"" . &ft . "\" not supported by available linters"
  endif
endfunction

" Run Typescript type checker
noremap <Leader>t :call TSTypeCheck()<cr>
function! TSTypeCheck()
  if (&ft=='typescript' || &ft=='typescriptreact')
    let linterBuffType = 'typescript'
    " Find local tsc, otherwise use global binary
    let localTsc = findfile('node_modules/.bin/tsc', '.;')
    if (!empty(localTsc))
      let tscBin = system(localTsc . " --noEmit " . bufname("%") . " 2>&1")
    else
      let tscBin = system("tsc --noEmit " . bufname("%") . " 2>&1")
    endif
  endif
  if (exists('tscBin'))
    split __Linter_Results__
    normal! ggdG
    setlocal buftype=nofile
    setlocal bufhidden=delete
    let &filetype = linterBuffType
    call append(0, split(tscBin, '\v\n'))
    checktime
  else
    echo "File type \"" . &ft . "\" not supported by available linters"
  endif
endfunction

" }}}
" Visual + Colorscheme {{{

" Adaptive color settings
set t_Co=256
if &term=~"xterm-256color"
  set termguicolors
endif

" Set colorscheme
set background=dark
colorscheme gruvbox

" Hide the scrollbars in MacVim
set guioptions-=L
set guioptions-=R

" Restore test-based tab bar in MacVim
set guioptions-=e

" Set the font to something pretty 
set guifont=Hasklig\ Regular:h14

" Always display statusline
set laststatus=2

" This is the old statusline code I wrote, uncomment if need be
" set statusline=%F%m\ %r%h%w\ \|\ \ [%{&ff}:%Y]\ %=[%04l,%04v]\ [%p%%]
" au InsertEnter * hi StatusLine term=reverse ctermfg=62 gui=undercurl guisp=Green
" au InsertLeave * hi StatusLine term=reverse ctermfg=238 ctermbg=253 gui=bold,reverse

" Offset the screen while scrolling to keep the cursor centered
set scrolloff=999

" Resize splits when the terminal dimensions change
autocmd VimResized * wincmd =

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
"set relativenumber

" Turn on intelligent word wrapping
set wrap linebreak nolist

" Line-breaks denoted with special character
set showbreak=↪\

" Display spaces before EOL as dots, wraps with chevrons
set list
set listchars=trail:•,extends:⟩,precedes:⟨

" Consider emoji characters to be full-width
set emoji

" }}}
" netrw {{{

" Fix for netrw buffers sticking around
autocmd FileType netrw setl bufhidden=wipe
autocmd FileType netrw setl nobuflisted

" When viewing directories, show nested tree mode
let g:netrw_liststyle=3

" Don't create .netrwhist files
let g:netrw_dirhistmax = 0

" Turn off pointless banner
let g:netrw_banner = 0

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

" }}}
" Vim-markdown {{{

" Enable syntax highlighting for fenced code blocks
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'scala', 'ruby', 'clojure', 'javascript']

" }}}
" Python-mode {{{

" Tell python-mode to shut up
let g:pymode_warnings = 0
let g:pymode_virtualenv = 0
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_folding = 0
let g:pymode_breakpoint = 0
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
" glsl.vim {{{

" Add *.frag and *.vert as file extensions
let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.frag,*.vert'

" }}}
" vim-javascript {{{

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" }}}
" vim-jsx {{{

" Only enable JSX highlighting w/ extension
let g:jsx_ext_required = 1

" }}}
" vim-tidal {{{

" Default tmux pane is incorrect (session: tidal, window 1, pane 2)
let g:tidal_default_config = {"socket_name": "default", "target_pane": "tidal:1.2"}

" let g:tidal_no_mappings = 1

" }}}

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
