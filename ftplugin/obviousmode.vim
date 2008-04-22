" ObviousMode: Clearly indicate visually whether Vim is in insert mode via the
" StatusLine highlight group.
"
" Brian Lewis <brian@lorf.org>
" 1.1 2008.04.22
"
" Thank you:
"   frogonwheels @ freenode #vim
"   Markus Braun
"
" 1. Put obviousmode.vim in plugins/
" 2. You probably want to
"      let laststatus = 2
" 3. Optionally,
"      let g:obviousModeInsertHi = "your settings"
"      let g:obviousModeCmdwinHi = "your settings"
"        (see :h highlight-args)

if &cp || (exists("g:loaded_obviousmode") && g:loaded_obviousmode)
    finish
endif

if !exists("g:obviousModeInsertHi")
    let g:obviousModeInsertHi = "term=reverse ctermbg=52"
endif

if !exists("g:obviousModeCmdwinHi")
    let g:obviousModeCmdwinHi = "term=reverse ctermbg=22"
endif

function! ObviousModeSaveOriginalHi()
    let l:orig = ""
    redir =>> l:orig | silent highlight StatusLine | redir END
    let s:obviousModeOriginalHi = join(split(l:orig)[2:-1], " ")
    unlet l:orig
endfunction

function! ObviousModeInsertEnter()
    exec "hi StatusLine ".g:obviousModeInsertHi
endfunction

function! ObviousModeInsertLeave()
    exec "hi StatusLine ".s:obviousModeOriginalHi
endfunction

function! ObviousModeCmdwinEnter()
    exec "hi StatusLine ".g:obviousModeCmdwinHi
endfunction

function! ObviousModeCmdwinLeave()
    exec "hi StatusLine ".s:obviousModeOriginalHi
endfunction

au VimEnter * call ObviousModeSaveOriginalHi()

au InsertEnter * call ObviousModeInsertEnter()
au InsertLeave * call ObviousModeInsertLeave()
au CmdwinEnter * call ObviousModeCmdwinEnter()
au CmdwinLeave * call ObviousModeCmdwinLeave()

let g:loaded_obviousmode = 1
