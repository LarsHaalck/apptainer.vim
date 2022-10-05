" Vim syntax file
" Language: Singularity/Apptainer Build Script
" Maintainer: Lars Haalck
" Latest Revision: October 05, 2022
" License: GPL3

if exists("b:current_syntax")
    finish
endif


syntax include @IncSh syntax/sh.vim
unlet b:current_syntax

" removing this breaks headers
syn iskeyword clear

syntax keyword apptainerKeyword contained Bootstrap From OSVersion MirrorURL Include Fingerprints Stage
syntax keyword apptainerRegionKeyword contained setup post test environment startscript runscript labels help files from
syntax match apptainerRegionKeyword /\v^\%\zs<(app\S+)>/
"
syntax match apptainerInstruction /\v^<(\S+)>\ze\:/ contains=apptainerKeyword skipwhite nextgroup=apptainerValue
"
syntax match apptainerRegionHeader /\v^\%<(\S+)>/ contains=apptainerRegionKeyword skipnl skipwhite nextgroup=apptainerShell
syntax match apptainerRegionHeader /\v^\%<files>(\s+from\s+\S+)?/ contains=apptainerRegionKeyword skipnl skipwhite nextgroup=apptainerShell

syntax region apptainerRegion start=/\v^\%\S+/ skip=/\v^[^%]+\_./ end=/\v^$/ fold transparent
syntax region apptainerVariable start="%{" end="}"

syntax region apptainerString contained start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region apptainerShell  contained keepend start=/\v/ skip=/\v\\\_./ end=/\v$/ contains=@IncSh
syntax region apptainerValue  contained keepend start=/\v/ skip=/\v\\\_./ end=/\v$/ contains=apptainerString,apptainerVariable

syntax region apptainerComment start=/\v^\s*#/ end=/\v$/
set commentstring=#\ %s

hi def link apptainerString String
hi def link apptainerKeyword Function
hi def link apptainerRegionKeyword Operator
hi def link apptainerVariable Identifier
hi def link apptainerComment Comment

let b:current_syntax = "apptainer"
