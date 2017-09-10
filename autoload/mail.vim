function! mail#new()
   let f = tempname()
   exe 'edit ' . f
   setf mail
   call setline(1, s:build_header())
   normal! G
endfunction

let s:headers = {
            \ 'From' : 'From: "' .  g:mail_sending_name . '" <' .  g:mail_sending_address . '>',
            \ 'Reply-To' : 'Reply-To: "' .  g:mail_sending_name . '" <' .  g:mail_sending_address . '>',
            \ }


function! s:build_header(...) abort
    let header = []
    call add(header, s:headers['From'])
    call add(header, 'Subject:')
    call add(header, 'Data:' . strftime("%c"))
    call add(header, 'To:')
    call add(header, s:headers['Reply-To'])
    call add(header, '')
    return header
endfunction