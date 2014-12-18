" Description: VimBuddy statusline character
" Usage:       Insert %{VimBuddy()} into your 'statusline'

if exists("g:loaded_vimbuddy") || &cp
 finish
endif

let g:loaded_vimbuddy = 1
let s:keepcpo         = &cpo
set cpo&vim

function! VimBuddy()
    " Take a copy for others to see the messages
    if ! exists("s:vimbuddy_msg")     | let s:vimbuddy_msg = v:statusmsg | endif
    if ! exists("s:vimbuddy_warn")    | let s:vimbuddy_warn = v:warningmsg | endif
    if ! exists("s:vimbuddy_err")     | let s:vimbuddy_err = v:errmsg | endif
    if ! exists("s:vimbuddy_onemore") | let s:vimbuddy_onemore = "" | endif
    "E121: Undefined variable: g:actual_curbuf "fixme
    if ! exists("g:actual_curbuf")    | let g:actual_curbuf = "" | endif

    "More faces ~_~ '_' $_$ *_* (-)_(-) +_+ >_> <_< @_@

    if ! exists("g:vimbuddy_focuslessFace") | let g:vimbuddy_focuslessFace = "-@-"  | endif
    if ! exists("g:vimbuddy_errFace")       | let g:vimbuddy_errFace       = "x@X"  | endif
    if ! exists("g:vimbuddy_warnFace")      | let g:vimbuddy_warnFace      = "O@O'" | endif
    if !exists("g:vimbuddy_wtfFace1")       | let g:vimbuddy_wtfFace1      = "¬@¬"  | endif
    if !exists("g:vimbuddy_wtfFace2")       | let g:vimbuddy_wtfFace2      = "O@o"  | endif
    if !exists("g:vimbuddy_wtfFace[3]")     | let g:vimbuddy_wtfFace3      = "o@O"  | endif
    if !exists("g:vimbuddy_happyFace")      | let g:vimbuddy_happyFace     = "o@o"  | endif

    if g:actual_curbuf != bufnr("%")
        " Not my buffer, sleeping
        return g:vimbuddy_focuslessFace
    elseif s:vimbuddy_err != v:errmsg
        let v:errmsg = v:errmsg . " "
        let s:vimbuddy_err = v:errmsg
        return g:vimbuddy_errFace
    elseif s:vimbuddy_warn != v:warningmsg
        let v:warningmsg = v:warningmsg . " "
        let s:vimbuddy_warn = v:warningmsg
        return g:vimbuddy_warnFace
    elseif s:vimbuddy_msg != v:statusmsg
        let v:statusmsg = v:statusmsg . " "
        let s:vimbuddy_msg = v:statusmsg
        let test = matchstr(v:statusmsg, 'lines *$')
        let num = substitute(v:statusmsg, '^\([0-9]*\).*', '\1', '') + 0
        " How impressed should we be
        if test != "" && num > 20
            let str = g:vimbuddy_wtfFace1
        elseif test != "" && num
            let str = g:vimbuddy_wtfFace2
        else
            let str = g:vimbuddy_wtfFace3
        endif
		  let s:vimbuddy_onemore = str
		  return str
	 elseif s:vimbuddy_onemore != ""
		let str = s:vimbuddy_onemore
		let s:vimbuddy_onemore = ""
		return str
    endif
    return g:vimbuddy_happyFace
endfunction

let &cpo= s:keepcpo
unlet s:keepcpo
