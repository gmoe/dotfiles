" Stylelint results buffer syntax file
" Language: Stylelint
" Creator: Griffin Moe <me@griffinmoe.com>
" Version: 1.0

if exists("b:current_syntax")
  finish
endif

syn clear

set nolist

syn keyword styleError ✖
syn match styleError /[\u2716]/

syn keyword styleWarning ⚠
syn match styleWarning /[\u26a0]/

syn match styleRuleName "\b[A-Za-z0-9/\-]\+"

syn match styleLineNumber "\(\d\+\):\(\d\+\)"

" syn region styleFileName start="^[A-Za-z]" end="\.\(sc|c|le\)ss$" keepend

syn region styleCode start=+`+ end=+`+ keepend

let b:current_syntax = "stylelint"

hi link styleLineNumber PreProc
hi link styleFileName Comment
hi link styleError Label
hi link styleWarning Type
hi link styleRuleName Underlined
hi link styleCode String
