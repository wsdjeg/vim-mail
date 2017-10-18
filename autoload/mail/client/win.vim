" load APIs
"

let s:BUFFER = SpaceVim#api#import('vim#buffer')


let s:bufnr = 0
let s:win_name = 'home'
let s:win_dir = 'INBOX'
let s:win_unseen = {}

function! mail#client#win#open()
    if s:bufnr == 0
        split __VIM_MAIL__
        let s:bufnr = bufnr('%')
        setlocal buftype=nofile nobuflisted nolist noswapfile nowrap cursorline nospell nomodifiable nowrap
        nnoremap <silent><buffer> <F5> :call <SID>refresh()<Cr>
        setfiletype VimMailClient
    endif
    call s:refresh()
endfunction

function! mail#client#win#currentDir()
    return s:win_dir
endfunction


function! s:refresh() abort
    let mails = mail#client#mailbox#get(s:win_dir)
    let lines = ['DATA      FROM                 SUBJECT']
    for id in keys(mails)
        call add(lines, mails[id]['data'] . '  ' . mails[id]['from'] . '  ' . mails[id]['subject'])
    endfor
    call s:BUFFER.buf_set_lines(s:bufnr, 0, len(lines), 0, lines)
endfunction

function! mail#client#win#status() abort
    return {
                \ 'dir' : s:win_dir,
                \ 'unseen' : get(s:win_unseen, 's:win_dir', 0),
                \ }
endfunction



