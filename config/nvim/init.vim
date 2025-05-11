" plug
call plug#begin()
  " environment
  Plug 'tpope/vim-sensible'

  " theme
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'NLKNguyen/papercolor-theme'

  " utility
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'airblade/vim-gitgutter'
  Plug 'scrooloose/nerdcommenter', { 'on': [ '<plug>NERDCommenterComment', '<plug>NERDCommenterUncomment' ] }

call plug#end()

" fix NLKNguyen/papercolor-theme#201
  source $VIMRUNTIME/colors/vim.lua
  set termguicolors

" appearance
  let g:airline_theme='murmur'

  colorscheme PaperColor
  set background=dark
  set number
  set cursorline
  set colorcolumn=80,120

" case insensitive search
  set ignorecase
  set smartcase

" auto
  " trailing whitespace
  autocmd BufEnter * EnableStripWhitespaceOnSave

" keybind
  " comment
  map <C-c><C-c> <plug>NERDCommenterComment
  map <C-c><C-u> <plug>NERDCommenterUncomment

" other
  " gitgutter
  set updatetime=100
