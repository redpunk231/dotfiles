let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
let g:fzf_layout = {'down': '25%'}


autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler | autocmd BufLeave <buffer> set showmode ruler


"command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--info=hidden', '-i', '--prompt=> ', '--pointer= ']}, <bang>0)
command! -bang -nargs=? -complete=dir Buffers call fzf#vim#buffers(<q-args>, {'options': ['--info=hidden', '-i', '--prompt=> ', '--pointer= ']}, <bang>0)
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


function! RipgrepFzf(query, fullscreen)
    let g:fzf_preview_window = ['right:50%', 'ctrl-/']
    let command_fmt = 'rg --max-filesize 100M --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), 1)
    let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
endfunction


"nmap <silent> <C-P> :Files<Cr>
"vmap <silent> <C-P> <esc>:Files<Cr>
"imap <silent> <C-P> <esc>:Files<Cr>

"nmap <silent> <F3>      :BTags<CR>
"vmap <silent> <F3> <esc>:BTags<CR>
"imap <silent> <F3> <esc>:BTags<CR>

"nmap <silent> <F10>         :Buffers<Cr>
"vmap <silent> <F10> <esc>   :Buffers<Cr>
"imap <silent> <F10> <esc>   :Buffers<Cr>

"nmap <silent> fg         :RG<Cr>
"vmap <silent> fg <esc>   :RG<Cr>
""imap <silent> fg <esc>   :RG<Cr>

let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'Normal'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }

