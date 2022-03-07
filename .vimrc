if has('nvim')
  " Neovim specific commands
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  set termguicolors
else
  " Standard vim specific commands
endif
execute pathogen#infect()

"colorscheme cwcolors
set number
nnoremap <F2> :set nonumber!<CR>
set nocompatible

syntax on
set tabstop=2
set autoindent
set hlsearch
set background=dark
"set paste

set ignorecase
set smarttab
set smartindent
set softtabstop=2
set shiftwidth=2
set expandtab
set laststatus=0
set ruler
set nofoldenable

set backspace=indent,eol,start

autocmd BufNewFile,BufRead *.tex set spell

setlocal spell
set spelllang=en_ca

" Fix the arrow keys
"set t_kd=

"set t_kr=
"set t_kl=

set t_Co=8
set t_Sb=m
set t_Sf=m

"color afterglow
"color gruvbox
"color deus
"color purify
"color molokai
"color desert
"color torte
"color slate
color onedark

map <C-o> :NERDTreeToggle<CR>

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\=/:

" Highlight trailing spaces.
let c_space_errors=1

:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" 00 -> 11 -> 10 -> 00
function! Cycle_numbers() abort
  if exists('+relativenumber')
    execute {
      \ '00': 'set number   | set relativenumber',
      \ '01': 'set number   | set norelativenumber',
      \ '10': 'set nonumber | set norelativenumber',
      \ '11': 'set number   | set norelativenumber' }\[&number . &relativenumber\]
  else
    set number!
  endif
endfunction

function! NumberCycle()
  if(&number == 0 && &relativenumber == 0)
    set nonumber | set relativenumber
  elseif(&number == 0 && &relativenumber == 1)
    set number   | set norelativenumber
  elseif(&number == 1 && &relativenumber == 0)
    set number   | set relativenumber
  elseif(&number == 1 && &relativenumber == 1)
    set nonumber | set norelativenumber
  endif
endfunc
noremap <silent> <F2> :call NumberCycle()<CR>
set autoindent
set scrolloff=10

if exists("b:current_syntax")
  finish
endif

runtime syntax/xml.vim

let s:current_syntax=b:current_syntax
unlet b:current_syntax

syntax include @YAML syntax/yaml.vim
syntax region ymlSnipInline matchgroup=rosparamTag start="\m<.\{-}rosparam.\{-}>" end="\m</.\{-}rosparam.\{-}>" contains=@YAML containedin=xmlEntity
hi link rosparamTag ModeMsg

let b:current_syntax=s:current_syntax
