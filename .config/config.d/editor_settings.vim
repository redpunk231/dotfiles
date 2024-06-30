set mouse=a
set encoding=UTF-8
set number
set noswapfile
set scrolloff=7
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"set autoindent
"set smartindent
set nowrap
set splitright
set splitbelow
set fileformat=unix
filetype indent on      " load filetype-specific indent files
set clipboard=unnamedplus " системный буфер обмена
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
set list
set list listchars=trail:·,precedes:«,extends:»,tab:▸\ 
set laststatus=0
set wildignore+=*.pyc,*.dll,*.pdb,*.cache,moc_*.cpp,moc_*.o
set sessionoptions+=winpos,terminal,folds

let g:indentLine_enabled = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊', '⸽']
autocmd FileType python IndentLinesEnable

"autocmd FileType python setlocal noexpandtab
if has('termguicolors')
    set termguicolors
endif
let g:gruvbox_bold = 0
let g:gruvbox_transparent_bg = 1
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_sign_column = 'bg0'
"colorscheme gruvbox

let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_foreground = 'original' "'mix'
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_ui_contrast = 'high'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 2
let g:sonokai_better_performance = 1
"colorscheme sonokai

let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
let g:everforest_disable_italic_comment = 1
"let g:everforest_transparent_background = 1
colorscheme everforest

let g:bufferline_show_bufnr = 0

let NERDTreeQuitOnOpen=1

let g:rainbow_active = 1

let g:minimap_width = 10
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

let b:ale_fixers = ['autopep8', 'yapf']
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0

let g:autopep8_max_line_length=120

au BufNewFile,BufRead *.py setlocal colorcolumn=120

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

set fillchars+=diff:╱

let g:autopep8_disable_show_diff=1

command! -nargs=0 DO DiffviewOpen
command! -nargs=0 DC DiffviewClose

"set foldmethod=indent

au VimEnter,VimResume * set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
au VimLeave,VimSuspend * set guicursor=a:hor20

set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
menu Encoding.cp1251  :e ++enc=cp1251<CR>
menu Encoding.cp866   :e ++enc=cp866<CR>
menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
menu Encoding.utf-8   :e ++enc=utf-8<CR>
