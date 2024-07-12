function! VisualSearch()
   let l:old_reg=getreg('"')
   let l:old_regtype=getregtype('"')
   normal! gvy
   let @/=escape(@@, '$.*/\[]')
   normal! gV
   call setreg('"', l:old_reg, l:old_regtype)
endfunction


function! GetTerminal()
    let s:path = expand('%:p:h')
    if $TMUX != ''
        "exe "silent !tmux split-window -p 30 'mc " . s:path . "'"
        exe "silent !tmux split-window -p 20"
    endif
    exe "redraw!"
endfunction


function! RsyncWin()
    let s:path = expand('%:p:h')
    if $TMUX != ''
        "exe "silent !tmux split-window -p 30 'mc " . s:path . "'"
        "exe "silent !tmux split-window -p 20"
        exe "silent !/home/redpunk/.scripts/rsync_win.sh " . getcwd()
    endif
    exe "redraw!"
endfunction


function TelescopeBuffersMin()
    :lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({sort_lastused=true, previewer=false, prompt_title=false, prompt_prefix='Buffers> '}))
endfunction


function TelescopeFiles()
    :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer=false, prompt_title=false, prompt_prefix='Files> '}))
    "if isdirectory(".git")
        ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({previewer=false, prompt_title=false, prompt_prefix='Files> '}))
    "else
        ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer=false, prompt_title=false, prompt_prefix='Files> '}))
    "endif
endfunction

function TelescopeGitBranches()
    if isdirectory(".git")
        :lua require'telescope.builtin'.git_branches(require('telescope.themes').get_dropdown({show_remote_tracking_branches=false, previewer=false, prompt_title=false, prompt_prefix='Branches> ', layout_config = {width = 70}}))
    endif
endfunction
