"Suppress persistent highlighting of searched terms
set nohlsearch
set autowriteall
set number
set nocompatible
filetype plugin indent on
syntax on
:au FocusLost * :wa

execute pathogen#infect()

set backspace=indent,eol,start
set ruler

let mapleader = ","

set tabstop=2 shiftwidth=2 expandtab

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

" edit and update vimrc from ANYWHERE
map <leader>rc :e ~/.vim/.vimrc<CR><C-W>
map <leader>rs :so %

" stop the process
map <leader>z z

" grep recursively, ignoring case
map <leader>g :! ack -i 

" FuzzyFinder and switchback commands
map <leader>e :e#<CR>
map <leader>b :FuzzyFinderBuffer<CR>
map <leader>f :FuzzyFinderFile<CR>
map <leader>c :FuzzyFinderRemoveCache<CR>

map <leader>s :%s/

map <leader>t :! rake test<CR>
map <leader>ta :! rake testall<CR>
map <leader>tf :! rake test:functionals<CR>
map <leader>tu :! rake test:units<CR>

" Split screen vertically and move between screens.
map <leader>v :vsp<CR> 
map <leader>h h
map <leader>< h
map <leader>l l
map <leader>> l
map <leader>= =

" Move between horizontally split screens.
map <leader>j j
map <leader>k k

" set shortcut for TlistToggle
map <leader>tt :TlistToggle<CR>

" set question mark to be part of a VIM word. in Ruby it is!
set isk=@,48-57,_,?,!,192-255
map <leader>n :tnext
map <leader>back t

" tags shortcuts
map fd 
map ps 
map <leader>sf :SweetVimRspecRunFocused
map <leader>sa :SweetVimRspecRunFile
map <leader>sp :SweetVimRspecRunPrevious
map uts :vsp<CR>l:Runittest<CR>
map fts :vsp<CR>l:Rfuntionaltest<CR>

map <leader>sa :! rake spec:acceptance<CR>
if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

" Run Ruby unit tests with gT (for all) or gt (only test under
" cursor) in command mode
augroup RubyTests
  au!
  autocmd BufRead,BufNewFile *_test.rb,test_*.rb
    \ :nmap gt V:<C-U>!$HOME/.vim/bin/ruby-run-focused-unit-test 
    \ % <C-R>=line("'<")<CR>p <CR>|
    \ :nmap gT :<C-U>!ruby %<CR>
augroup END

let Tlist_Ctags_Cmd='/usr/bin/ctags'
