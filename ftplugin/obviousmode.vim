" ObviousMode: Clearly indicate visually whether Vim is in insert mode via the
" StatusLine highlight group.
"
" Brian Lewis <brian@lorf.org>
" 1.0 2008.04.12
"
" Thank you to frogonwheels @ freenode #vim for help.
"
" 1. Put obviousmode.vim in plugins/
" 2. If you have a preference about how the status line should look when in
"    insert mode, let g:obviousModeInsertHi = "your settings" (see :h
"    highlight-args)

if &cp || (exists("g:loaded_obviousmode") && g:loaded_obviousmode)
    finish
endif

stopinsert
set laststatus=2

if !exists("g:obviousModeInsertHi")
    let g:obviousModeInsertHi = "term=reverse ctermbg=5"
endif

function! ObviousModeInsertEnter()
    call ObviousModeSaveOriginalHi()
    exec "hi StatusLine ".g:obviousModeInsertHi
endfunction

function! ObviousModeInsertLeave()
    exec "hi StatusLine ".g:obviousModeOriginalHi
endfunction

function! ObviousModeSaveOriginalHi()
    let l:orig = ""
    redir =>> l:orig | silent highlight StatusLine | redir END
    let g:obviousModeOriginalHi = join(split(l:orig)[2:-1], ' ')
    unlet l:orig
endfunction

au InsertEnter * call ObviousModeInsertEnter()
au InsertLeave * call ObviousModeInsertLeave()

let g:loaded_obviousmode = 1
