" plug
call plug#begin('~/.vim/plugged')
  " enviroment
  Plug 'tpope/vim-sensible'

  " theme
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'NLKNguyen/papercolor-theme'

  " completion
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/async.vim'

  " language server
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " utility
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'airblade/vim-gitgutter'
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'scrooloose/nerdcommenter', { 'on': [ '<plug>NERDCommenterComment', '<plug>NERDCommenterUncomment' ] }

call plug#end()


" appearance
  let g:airline_theme='murmur'

  colorscheme PaperColor
  set background=dark
  set number
  set cursorline
  set colorcolumn=80,120
  set t_Co=256

" case insensitive search
  set ignorecase
  set smartcase

" auto
  " trailing whitespace
  autocmd BufEnter * EnableStripWhitespaceOnSave


" keybind
  " tab completion
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

  " tree
  map <C-n> :NERDTreeToggle<CR>

  " comment
  map <C-c><C-c> <plug>NERDCommenterComment
  map <C-c><C-u> <plug>NERDCommenterUncomment

  " asyncomplete
  set completeopt-=preview

  let g:lsp_text_edit_enabled = 0
  let g:lsp_signature_help_enabled = 0

" language server (from asyncomplete)
  let g:lsp_text_edit_enabled = 0
  let g:lsp_signature_help_enabled = 0

  if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
  endif

" other
  " gitgutter
  set updatetime=100
