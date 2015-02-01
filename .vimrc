" Use vim settings, rather than vi
set nocompatible

" ================ General Config ====================
set number                      " Line numbers are good
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim

" 256 colors
set t_Co=256
set t_AB=[48;5;%dm
set t_AF=[38;5;%dm


" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Display whitespaces ==============
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitespace:
:match ExtraWhitespace /\s\+$/

" ================ Search Settings  =================
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" scroll with the mouse
set mouse=a

set nocompatible
set bs=2
set background=dark
set wrapmargin=8
set ruler

set showmatch  " matching parenthesis
set cursorline " display line

" CTRL+SPC for completion
imap  <C-Space> <C-X><C-O>

" ==================== Plugin =========================
" Vundle
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/vundle' " the plug-in manager for Vim

Plugin 'flazz/vim-colorschemes'                 " one colorscheme pack to rule them all!
Plugin 'godlygeek/tabular'                      " text filtering and alignment
Plugin 'kchmck/vim-coffee-script'               " coffeeScript support
Plugin 'othree/javascript-libraries-syntax.vim' " syntax for JavaScript libraries
Plugin 'tpope/vim-commentary'                   " comment stuff out
Plugin 'tpope/vim-dispatch'                     " asynchronous build and test dispatcher
Plugin 'tpope/vim-fugitive'                     " a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-haml'                         " runtime files for Haml, Sass, and SCSS
Plugin 'tpope/vim-rails'                        " Ruby on Rails power tools
Plugin 'bling/vim-airline'                      " lean & mean status/tabline for vim that's light as air
Plugin 'fatih/vim-go'                           " Go development plugin for Vim
call vundle#end()

" vim-airline
set laststatus=2

filetype plugin on
filetype indent on

" ================= js libraries ======================
let g:used_javascript_libs = 'jquery'

" =================== Bindings ========================
map  <C-l> :tabn<CR>   " tabnext
map  <C-h> :tabp<CR>   " tabprevious
map  <C-n> :tabnew<CR> " new tab

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" save file fith sudo
cmap w!! w !sudo tee >/dev/null %

" colorscheme (does not load at beginning of file)
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme Tomorrow-Night "set up a color scheme

" =================== Filetypes =======================
au BufNewFile,BufRead *.god   set filetype=ruby
au BufNewFile,BufRead *.pryrc set filetype=ruby
