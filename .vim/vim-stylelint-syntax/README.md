# vim-stylelint-syntax

This is a Vim syntax-highlighter for [Stylelint][] logging output, definitely a
weird niche right?

I'm not a huge fan of the asynchronous linters, instead I rely on [git hooks][]
and get in-editor feedback with a key binding that opens a split with ESLint
output for the current buffer. If that sounds like an appealing alternative
then you're the target audience for this plugin!

If you're looking for a plugin that gives you line-by-line linter output you
will probably prefer something like [ale][] or [Syntastic][]. This also
requires a bit of familiarity with Vim and manual configuration to get working.

## Installation

If you're unfamiliar with vim, consider using something like [vim-plug][] to
maintain your plugins:

1. Add the following to your `.vimrc`:
```vim
Plug 'gmoe/vim-stylelint-syntax'
```
2. Restart vim and execute `:PlugInstall` to automatically download and install
   this plugin.

Or consider using Vim 8's [native plugin manager][vim8] and clone this repo
into your bundle.

## Usage

My `.vimrc` has a key binding to pipe the output of [Stylelint][] into a buffer
and open that buffer into a split. If you want a similar setup the following
is the bare minimum to support it, bound to `<Leader>e`:

```vim
noremap <Leader>e :call StylelintFileExternal()<cr>

function! StylelintFileExternal()
  if (&ft=='javascript' || &ft=='javascript.jsx' || &ft=='javascriptreact')
    let linterBuffType = 'stylelint'

    " Recursively find local stylelint, otherwise use global binary
    let localStylelint = findfile('node_modules/.bin/stylelint', '.;')
    if (!empty(localStylelint))
      let linter = system(localStylelint . " " . bufname("%") . " 2>&1")
    else
      let linter = system("stylelint " . bufname("%") . " 2>&1")
    endif
  elseif (&ft=='myfile')
    " Add other linters! Maybe write highlighters for them?
  endif
  if (exists('linter'))
    split __Linter_Results__
    normal! ggdG
    setlocal buftype=nofile
    setlocal bufhidden=delete
    let &filetype = linterBuffType
    call append(0, split(linter, '\v\n'))
  else
    echo "File type not supported by available linters"
  endif
endfunction
```

If you want more hints on how to integrate other linters or how this setup
works, check out [my config][]. Note that this plugin does not automatically
set the file type of the buffer so it can play nicely with other future linter
highlighters. You'll have to set it manually similar to the snippet above (`let
&filetype = linterBuffType`) or set it with an [autocommand][] like below:

```vim
au! BufRead,BufNewFile __Linter_Results__ setfiletype stylelint
```

If you go with this option, you might want to change the name of the split
to reflect the linter being used.

[Stylelint]: https://stylelint.io/
[ale]: https://github.com/dense-analysis/ale
[Syntastic]: https://github.com/vim-syntastic/syntastic
[vim-plug]: https://vimhelp.org/repeat.txt.html#packages
[vim8]: https://vimhelp.org/repeat.txt.html#packages
[git hooks]: https://githooks.com/
[my config]: https://github.com/gmoe/dotfiles/blob/master/.vimrc
[autocommand]: https://learnvimscriptthehardway.stevelosh.com/chapters/12.html
