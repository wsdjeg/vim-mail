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
endfunction


function! mail#client#send(command)
    call s:JOB.send(s:job_id, a:command)   
endfunction
