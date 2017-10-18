let s:bufnr = 0
let s:win_name = 'home'
let s:win_dir = 'INBOX'
let s:win_unseen = {}

function! mail#client#win#open()
    if s:bufnr == 0
        split __VIM_MAIL__
        let s:bufnr = bufnr('%')
        setlocal buftype=nofile nobuflisted nolist noswapfile nowrap cursorline nospell nomodifiable
        setfiletype VimMailClient
    endif
endfunction

function! mail#client#win#status() abort
    return {
                \ 'dir' : s:win_dir,
                \ 'unseen' : get(s:win_unseen, 's:win_dir', 0),
                \ }
endfunction



