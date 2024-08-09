source $HOME/.config/nvim/config.d/functions.vim

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

map ff     viw<ESC>:call VisualSearch()<CR>/<CR>N

:nmap <F1> <nop>
:vmap <F1> <nop>
:imap <F1> <nop>

nmap <silent> <F2> : NvimTreeToggle<CR>
vmap <silent> <F2> <esc>:NvimTreeToggle<CR>
imap <silent> <F2> <esc>:NvimTreeToggle<CR>

nmap <silent> <F3>      :BTags<CR>
vmap <silent> <F3> <esc>:BTags<CR>
imap <silent> <F3> <esc>:BTags<CR>

autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

map <F6> :emenu Encoding.<Tab>

nmap <silent> <F7>      :IndentLinesToggle<CR>
vmap <silent> <F7> <esc>:IndentLinesToggle<CR>
imap <silent> <F7> <esc>:IndentLinesToggle<CR>

nmap <silent> <F8>       :bd<CR>
vmap <silent> <F8> <esc> :bd<CR>
imap <silent> <F8> <esc> :bd<CR>

"nmap <silent> <F9>       :call GetTerminal()<CR>
"vmap <silent> <F9> <esc> :call GetTerminal()<CR>
"imap <silent> <F9> <esc> :call GetTerminal()<CR>

nmap <silent> <F10>         :call TelescopeBuffersMin()<Cr>
vmap <silent> <F10> <esc>   :call TelescopeBuffersMin()<Cr>
imap <silent> <F10> <esc>   :call TelescopeBuffersMin()<Cr>

nmap <silent> <F11>      :BufferLineCyclePrev<CR>
vmap <silent> <F11> <esc>:BufferLineCyclePrev<CR>
imap <silent> <F11> <esc>:BufferLineCyclePrev<CR>

nmap <silent> <F12>      :BufferLineCycleNext<CR>
vmap <silent> <F12> <esc>:BufferLineCycleNext<CR>
imap <silent> <F12> <esc>:BufferLineCycleNext<CR>

nmap <silent> <F14>       :NvimTreeFindFile<CR>
vmap <silent> <F14> <esc> :NvimTreeFindFile<CR>
imap <silent> <F14> <esc> :NvimTreeFindFile<CR>

nmap <silent> <F15> :TagbarToggle<CR>
vmap <silent> <F15> <esc>:TagbarToggle<CR>
imap <silent> <F15> <esc>:TagbarToggle<CR>

nmap <silent> <F23>      :BufferLineMovePrev<CR>
vmap <silent> <F23> <esc>:BufferLineMovePrev<CR>
imap <silent> <F23> <esc>:BufferLineMovePrev<CR>

nmap <silent> <F24>      :BufferLineMoveNext<CR>
vmap <silent> <F24> <esc>:BufferLineMoveNext<CR>
imap <silent> <F24> <esc>:BufferLineMoveNext<CR>

nmap <silent> <C-P>         :call TelescopeFiles()<Cr>
vmap <silent> <C-P> <esc>   :call TelescopeFiles()<Cr>
imap <silent> <C-P> <esc>   :call TelescopeFiles()<Cr>

nmap <silent> <A-p>         :Telescope buffers sort_mru=true ignore_current_buffer=true<Cr>
vmap <silent> <A-p> <esc>   :Telescope buffers sort_mru=true ignore_current_buffer=true<Cr>
imap <silent> <A-p> <esc>   :Telescope buffers sort_mru=true ignore_current_buffer=true<Cr>

nmap <silent> <A-l>         :LspRestart<Cr>
vmap <silent> <A-l> <esc>   :LspRestart<Cr>
imap <silent> <A-l> <esc>   :LspRestart<Cr>

nmap <silent> <leader>fg         :Telescope live_grep<CR>
vmap <silent> <leader>fg <esc>   :Telescope live_grep<CR>

nmap <silent> <leader>fw         :Telescope grep_string<CR>
vmap <silent> <leader>fw <esc>   :Telescope grep_string<CR>

nmap <silent> <leader>gb            :call TelescopeGitBranches()<Cr>
vmap <silent> <leader>gb    <esc>   :call TelescopeGitBranches()<Cr>
imap <silent> <leader>gb    <esc>   :call TelescopeGitBranches()<Cr>


" turn off search highlight
"nnoremap f<ESC> :nohlsearch<CR>
