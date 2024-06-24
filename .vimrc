set nocompatible
filetype off

call plug#begin()
Plug 'gmarik/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
"Plugin 'L9'
"Plugin 'git://git.wincent.com/command-t.git'
""Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()

filetype plugin indent on

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

filetype plugin indent on

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set scrolloff=12
set textwidth=79
set wildmenu
set relativenumber
set encoding=utf-8


syntax on
set number

highlight overlength ctermbg=234
match overlength /\%81v.\+/

colorscheme wildcharm


"Allow python folding
":setlocal foldmethod=indent
hi Folded ctermbg=black ctermfg=216

highlight cursorline term=bold cterm=bold ctermbg=235
highlight Search ctermbg=54
noremap <leader>cl :set cursorline!<cr>
set cursorline

"au FileType tex setlocal nocursorline
au FileType tex :NoMatchParen

autocmd filetype make setlocal noexpandtab

"Latex files, @w compiles, @o opens
autocmd BufRead,BufNewFile *.tex let @w=':w:!compile_article %'
autocmd BufRead,BufNewFile *.tex let @d=':w:!pdflatex %'
"build_pdf to compile markdown and latex files into pdfs
autocmd BufRead,BufNewFile *.md let @w=':wa:!build_pdf %:r'
"use serv_tex, for compiling tex on a server"
autocmd BufRead,BufNewFile *.tex let @o=':!mupdf %:r.pdf &> /dev/null &'
autocmd BufRead,BufNewFile *.md let @o=':!mupdf %:r.pdf &> /dev/null &'
"autocmd BufRead,BufNewFile *.md let @w=':w:!pandoc -V linestretch:2 % -f markdown -t latex -s -o %:r.tex; pdflatex %:r; bibtex %:r; pdflatex %:r; pdflatex %:r'
autocmd BufRead,BufNewFile *.md let @o=':!mupdf %:r.pdf &> /dev/null &'
autocmd BufRead,BufNewFile *.md let @p=':w:!pandoc % -V geometry:margin=1.25in -f markdown -t latex -s -o %:r.pdf'
autocmd BufRead,BufNewFile *.cpp let @r=':!./run | less'

"autocmd BufRead,BufNewFile *.tex let @w=':w:!pdflatex %:r; bibtex %:r; pdflatex %:r; pdflatex %:r'
" autocmd BufRead,BufNewFile *.md let @w=':w:!pandoc % -V fontsize=12pt -V linestretch:2 -V geometry:margin=1.25in -f markdown -t latex -s -o %:r.tex; pdflatex %:r; bibtex %:r; pdflatex %:r; pdflatex %:r'

"Persistent undos
set undodir=$XDG_DATA_HOME/vim/undo
set undofile
set undolevels=1000
set undoreload=10000

set incsearch
set hlsearch
hi clear SpellBad
hi SpellBad cterm=underline
"setlocal spell spelllang=en_us

"Macro to place text in a visual block into math mode
let @m='c$$Pw'
let @j='040l'
let @t='c\text{}Pw'
let @v='F lvf h'

"Add _ to characters that w goes to
"set iskeyword-=_

"Display end of line whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

"Insert setext headers (for markdown)
let mapleader = ","
map <leader>h1 VypVr=A
map <leader>h2 VypVr-A
"To-do list command
map <leader>t dmaGpGA (@@@)v:s/@@@/\=strftime("%m\/%d\/%y")`a

