" http://blog.csdn.net/thundercumt/article/details/51742115


let s:PASSWORD = SpaceVim#api#import('password')

function! mail#command#login(username, password)

    let str = s:PASSWORD.generate_simple(5)

    return join([str, 'LOGIN', a:username, a:password], ' ')


endfunction
