" Quality of life
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber 
set scrolloff=5

" Bracket and quote completion 
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" Plugins
call plug#begin('~/.vim/plugged')
" Auto complete and lsp"
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Color themes
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/everforest'
    Plug 'nordtheme/vim'
    Plug 'catppuccin/vim', { 'as': 'catppuccin' }
    
" Statusline plugin
    Plug 'itchyny/lightline.vim'

" Git integration for lightline
    Plug 'itchyny/vim-gitbranch'
call plug#end()

colorscheme catppuccin_frappe

" Popup menu background and text
highlight Pmenu      ctermfg=white    ctermbg=60    " Text: white, BG: surface0 (#313244)
highlight PmenuSel   ctermfg=black    ctermbg=109   " Selected: black on teal (#94e2d5)
highlight PmenuSbar  ctermbg=238                  " Scrollbar: surface1 (#45475a)
highlight PmenuThumb ctermbg=109                  " Scrollbar thumb: teal (#94e2d5)


" Auto complete and lsp
if executable('pyright')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyright',
        \ 'cmd': {server_info->['pyright-langserver', '--stdio']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['cpp', 'c', 'objc', 'objcpp'],
        \ })
endif

let g:asyncomplete_auto_popup = 1

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Lightline
set laststatus=2

let g:lightline = { 
  \ 'colorscheme': 'catppuccin_frappe', 
  \ 'active': {
  \   'left': [ [ 'mode' ], [ 'gitbranch' ], [ 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'filetype' ], [ 'lineinfo' ], [ 'percent' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'gitbranch': 'MyGitBranch'}}

function! LightlineFilename()
  let filename = expand('%:t')
  return filename !=# '' ? filename : '[No Name]'
endfunction

function! MyGitBranch()
  let branch = gitbranch#name()
  return branch !=# '' ? ' ' . branch : ''
endfunction
