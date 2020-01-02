" pylint results buffer syntax file
" Language: pylint
" Creator: Griffin Moe <me@griffinmoe.com>
" Version: 1.0

if exists("b:current_syntax")
  finish
endif

syn clear

syn match pylintFileName "^\S\+\.py"
syn match pylintLineNumber "\(\d\+\):\(\d\+\)"
syn match pylintRuleCode "[A-Z]\+\d\d\d\d"
syn match pylintRuleName "([a-z/\-]\+)$"

syn region pylintDivider start="^-" end="-$" keepend

syn match pylintResultGood "10\.00/10"
syn match pylintResultOkay "[6789]\.\d\d"
syn match pylintResultBad "[012345]\.\d\d"

syn match pylintDeltaPositive "+\d\.\d\d"
syn match pylintDeltaNeutral "+0\.00"
syn match pylintDeltaNegative "-\d\.\d\d"

let b:current_syntax = "pylint"

hi link pylintFileName Type
hi link pylintLineNumber PreProc
hi link pylintRuleName Underlined
hi link pylintRuleCode String
hi link pylintDivider Comment

hi pylintResultGood term=bold ctermfg=10
hi link pylintResultOkay Type
hi pylintResultBad term=bold ctermfg=1

hi pylintDeltaPositive term=bold ctermfg=10
hi link pylintDeltaNeutral Comment
hi pylintDeltaNegative term=bold ctermfg=1

