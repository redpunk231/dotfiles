call plug#begin()

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'ray-x/lsp_signature.nvim'

" FileManager
Plug 'kyazdani42/nvim-tree.lua'

" Snippets
Plug 'dcampos/nvim-snippy'
Plug 'honza/vim-snippets'

" Commenter
Plug 'scrooloose/nerdcommenter'

" Скобки и линии отступов
Plug 'frazrepo/vim-rainbow'
Plug 'Yggdroot/indentLine'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Buffer/Tab line
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" GIT
Plug 'airblade/vim-gitgutter'

" Python
Plug 'raimon49/requirements.txt.vim'

" Tags
Plug 'majutsushi/tagbar'

" Diff
Plug 'sindrets/diffview.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'

" ALE
"Plug 'dense-analysis/ale'

" Python PEP8
Plug 'tell-k/vim-autopep8'

" Sessions
Plug 'rmagatti/auto-session'

" Telescope
Plug 'nvim-telescope/telescope.nvim'

" Color schemas
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'shaunsingh/seoul256.nvim'
Plug 'sainnhe/sonokai'

" Python folding
"Plug 'tmhedberg/SimpylFold'

" Deps
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

call plug#end()
