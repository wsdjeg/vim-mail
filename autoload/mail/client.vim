let s:job_id = 0

let s:JOB = SpaceVim#api#import('job')

function! mail#client#connect(ip, port)
    let argv = ['telnet', a:ip, a:port]
    let s:job_id = s:JOB.start(argv,
                \ {
                \ 'on_stdout' : function('s:on_stdout'),
                \ 'on_stderr' : function('s:on_stderr'),
                \ 'on_exit' : function('s:on_exit'),
                \ }
                \ )

endfunction


function! s:on_stdout(id, data, event) abort
    echom string(a:data)
endfunction



function! s:on_stderr(id, data, event) abort
    echom string(a:data)
endfunction

function! s:on_exit(id, data, event) abort
    echom string(a:data)
    let s:job_id = 0
endfunction


function! mail#client#send(command)
    call s:JOB.send(s:job_id, a:command)   
endfunction

function! mail#client#open()
    if s:job_id == 0
        let username = input('USERNAME: ')
        let password = input('PASSWORD: ')
        if !empty(username) && !empty(password)
            call mail#client#connect('imap.163.com', 143)
            call mail#client#send(mail#command#login(username, password))
        endif
    endif
    call mail#client#win#open()
endfunction
