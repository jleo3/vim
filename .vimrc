"Suppress persistent highlighting of searched terms
set nohlsearch

" pathogen
execute pathogen#infect()

" Use Vim's undofiles
set undofile
set undodir=$HOME/.vim/undo

set showmatch
colorscheme delek
set autoindent
set si
set autowriteall
set number
set nocompatible
filetype plugin indent on
filetype plugin on
filetype off
syntax on
au FocusLost * :wa
au BufRead,BufNewFile *.rabl setf ruby

" vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'thoughtbot/vim-rspec'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'reedes/vim-pencil'
Plugin 'elixir-lang/vim-elixir'

" Allow project-specific .vimrc files
set exrc
set secure

set backspace=indent,eol,start
set ruler

let mapleader = ","

set tabstop=2 shiftwidth=2 expandtab

" CtrlP and switchback commands and config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_show_hidden = 1

map <leader>e :e#<CR>
map <leader>f :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
" <F5> to refresh
" <c-y> to create a new file
" <c-v> to open in new vertical split
" <c-d> to switch to filename only
" <c-z> to mark/unmark multiple files and <c-o> to open

"incrementally search file"
set incsearch

"put filename in title bar"
set title

"allow backspacing over everything in INSERT mode
set bs=2

"insert a space above/below current line
map <S-Enter> O<Esc>j
map <CR> o<Esc>k

"search for files like bash"
set wildmode=list:longest

" autosave if I switch to another buffer
set autowrite

"move swp files into .vim-tmp/"
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" set the arglist to files with merge conflicts
map <leader>q :args `git diff --name-only --diff-filter=U`<CR>

" edit and update vimrc from ANYWHERE
map <leader>rc :e ~/.vim/.vimrc<CR><C-W>
map <leader>rs :so %

" vim-bad-whitespace
map <leader>w :EraseBadWhitespace<CR>

" stop the process
map <leader>z z

" paste from system clipboard
map <leader>p "*p<CR>

" run the last vim command
map <leader>d @:

" paste copied text over current word
map <leader>r viw"0p

" HardMode
nnoremap <leader>u <Esc>:call ToggleHardMode()<CR>

map <leader>tf :! rake test:functionals<CR>
map <leader>tu :! rake test:units<CR>

" Split screen vertically and move between screens.
map <leader>v :vsp<CR>
map <leader>h h
map <leader>l l
map <leader>= =

" set shortcut for TlistToggle
map <leader>tt :TlistToggle<CR>

" set question mark to be part of a VIM word. in Ruby it is!
set isk=@,48-57,_,?,!,192-255
map <leader>n :tnext
map <leader>back t

" tags shortcuts
map fd 
map ps 
map uts :vsp<CR>l:Runittest<CR>
map fts :vsp<CR>l:Rfuntionaltest<CR>

map <leader>sa :! rake spec:acceptance<CR>
if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

" Control+J/K maps -> go to next/previous in buffer
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>

" Run Ruby unit tests with gT (for all) or gt (only test under
" cursor) in command mode
augroup RubyTests
  au!
  autocmd BufRead,BufNewFile *_test.rb,test_*.rb
    \ :nmap gt V:<C-U>!$HOME/.vim/bin/ruby-run-focused-unit-test
    \ % <C-R>=line("'<")<CR>p <CR>|
    \ :nmap gT :<C-U>!ruby %<CR>
augroup END

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>T :call RunLastSpec()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>

" vim-rails mappings
nnoremap <Leader>a :A<CR>
nnoremap <Leader>A :AV<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" vim-pencil config
let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType textile call pencil#init()
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" bind K to grep word under cursor, 0 to select file
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap 0 :.cc<CR>

let Tlist_Ctags_Cmd='/usr/bin/ctags'

" From https://github.com/Casecommons/vim-config/commit/908a6bdd223b72c1495bbf41da3fe5c8e4d2d949
" inserts [#SID] into your commit message,
" assuming your branches follow the naming scheme: SID_description
function! InsertStoryId()
  let sid_command = "mi"                           " mark current position
  let sid_command = sid_command."\/On branch\<CR>" " move to line with branch name
  let sid_command = sid_command."ww"               " move to first char of story #
  let sid_command = sid_command."yt_"              " yank the story #
  let sid_command = sid_command."\/^#\<CR>gg"      " move to first #... line
  let sid_command = sid_command."O"                " add blank line in insert mode
  let sid_command = sid_command."[#\<esc>pA] "     " insert [#SID]
  let sid_command = sid_command."\<esc>"           " switch to normal mode

  exec "normal! ".sid_command
endfunction

command! Sid :call InsertStoryId()

nnoremap <leader>i :Sid<CR>

