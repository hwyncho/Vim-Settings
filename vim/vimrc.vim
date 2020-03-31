""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Settings for Vim.
" Last updated on 2020. 03. 31.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
let s:vimplug_path=join([$HOME, '.vim', 'autoload', 'plug.vim'], '/')
let s:plugin_root=join([$HOME, '.vim', 'plugged'], '/')

function! s:IS_VIMPLUG_INSTALLED()
    if filereadable(s:vimplug_path)
        return 1
    else
        return 0
    endif
endfunction

function! VIMPLUG_INSTALL()
    if s:IS_VIMPLUG_INSTALLED()
        echomsg 'vim-plug is already installed at: ' s:vimplug_path
    else
        silent execute '!clear'
        execute '!curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -fLo ' s:vimplug_path ' --create-dirs'
    endif
endfunction

function! s:IS_PLUGIN_INSTALLED(plugin_name)
    if isdirectory(join([s:plugin_root, a:plugin_name], '/'))
        return 1
    else
        return 0
    endif
endfunction

function! s:IS_PLUGIN_LOADED(plugin_name)
    if stridx(&runtimepath, a:plugin_name) > -1
        return 1
    else
        return 0
    endif
endfunction

let &compatible=0

if s:IS_VIMPLUG_INSTALLED()
    call plug#begin(s:plugin_root)
        " --> UI
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'dracula/vim', { 'as': 'dracula' }
        Plug 'majutsushi/tagbar'
        Plug 'scrooloose/nerdtree'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        " --> File
        Plug 'chrisbra/csv.vim'

        " --> Editor
        Plug 'alvan/vim-closetag'
        Plug 'nathanaelkane/vim-indent-guides'
        Plug 'tpope/vim-surround'

        " --> Git
        Plug 'airblade/vim-gitgutter'
        Plug 'tpope/vim-fugitive'

        " --> Snippets
        Plug 'Shougo/neosnippet.vim'
        Plug 'Shougo/neosnippet-snippets'

        " --> Formatters
        Plug 'prettier/vim-prettier', {
\           'do': 'npm install',
\           'for': [
\               'css',
\               'html',
\               'javascript',
\               'json',
\               'markdown',
\               'yaml'
\           ]
\       }

        " --> Intellisense
        Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'mattn/vim-lsp-settings'

        " --> Autocompletion
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-buffer.vim'
        Plug 'prabirshrestha/asyncomplete-file.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
    call plug#end()
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
let g:colors_name='default'

if stridx($TERM, '256color') > -1
    let &termguicolors=1
endif

let &laststatus=2
let &ruler=1

let &splitbelow=1
let &splitright=1

let &mouse='a'

" --> ctrlp.vim
if s:IS_PLUGIN_INSTALLED('ctrlp.vim') && s:IS_PLUGIN_LOADED('ctrlp.vim')
    let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_switch_buffer='et'
endif

" --> dracula
if s:IS_PLUGIN_INSTALLED('dracula') && s:IS_PLUGIN_LOADED('dracula')
    if &termguicolors == 1
        let &background='dark'
        let g:colors_name='dracula'
    endif
endif

" --> tagbar
if s:IS_PLUGIN_INSTALLED('tagbar') && s:IS_PLUGIN_LOADED('tagbar')
    let g:tagbar_type_markdown={
\       'ctagstype': 'markdown',
\       'kinds': ['h:Heading_L1', 'i:Heading_L2','k:Heading_L3']
\   }
endif

" --> nerdtree
if s:IS_PLUGIN_INSTALLED('nerdtree') && s:IS_PLUGIN_LOADED('nerdtree')
    autocmd StdinReadPre * let s:std_in=1

    let g:NERDTreeDirArrowExpandable='▸'
    let g:NERDTreeDirArrowCollapsible='▾'
endif

" --> vim-airline
if s:IS_PLUGIN_INSTALLED('vim-airline') && s:IS_PLUGIN_LOADED('vim-airline')
    let &showmode=0

    let g:airline#extensions#branch#enabled=1
    let g:airline#extensions#coc#enabled=1
    let g:airline#extensions#hunks#enabled=1
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tagbar#enabled=1
    let g:airline_powerline_fonts=0

    if s:IS_PLUGIN_INSTALLED('vim-airline-themes') && s:IS_PLUGIN_LOADED('vim-airline-themes')
        if g:colors_name == 'dracula'
            let g:airline_theme='dracula'
        endif
    endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File
let &encoding='utf-8'
let &fileencoding='utf-8'

let &backup=0
let &swapfile=0
let &writebackup=0

let &history=1024

let &undodir=join([$HOME, '.cache', 'vim', 'undo'], '/')
let &undolevels=1024
let &undofile=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editor
let &list=1
let &listchars=join(['extends:>', 'nbsp:·', 'precedes:‹', 'tab:» ', 'trail:·'], ',')

let &hlsearch=1
let &number=1
let &showbreak='    '
let &showmatch=1

let &autoindent=1
let &breakindent=1
let &cindent=1
let &smartindent=1

let &expandtab=1
let &shiftwidth=4
let &tabstop=4
let &wrap=1

let &completeopt=join(['menu', 'menuone', 'noinsert', 'noselect', 'preview'], ',')

syntax on

" --> vim-indent-guides
if s:IS_PLUGIN_INSTALLED('vim-indent-guides') && s:IS_PLUGIN_LOADED('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_guide_size=1
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets
" --> neosnippet.vim
if s:IS_PLUGIN_INSTALLED('neosnippet.vim') && s:IS_PLUGIN_LOADED('neosnippet.vim')
    if has('conceal')
        let &conceallevel=2
        let &concealcursor='niv'
    endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Intellisense
" --> vim-lsp
let &foldmethod='expr'
let &foldexpr='lsp#ui#vim#folding#foldexpr()'
let &foldtext='lsp#ui#vim#folding#foldtext()'

let g:lsp_fold_enabled=0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocompletion
" --> asyncomplete.vim
if s:IS_PLUGIN_INSTALLED('asyncomplete.vim') && s:IS_PLUGIN_LOADED('asyncomplete.vim')
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
endif

" --> asyncomplete-buffer.vim
if s:IS_PLUGIN_INSTALLED('asyncomplete-buffer.vim') && s:IS_PLUGIN_LOADED('asyncomplete-buffer.vim')
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
\       'name': 'buffer',
\       'whitelist': ['*'],
\       'blacklist': ['go'],
\       'completor': function('asyncomplete#sources#buffer#completor'),
\           'config': {
\           'max_buffer_size': 4096,
\       }
\   }))

    let g:asyncomplete_buffer_clear_cache=1
endif

" --> asyncomplete-file.vim
if s:IS_PLUGIN_INSTALLED('asyncomplete-file.vim') && s:IS_PLUGIN_LOADED('asyncomplete-file.vim')
    call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
\       'name': 'file',
\       'whitelist': ['*'],
\       'priority': 10,
\       'completor': function('asyncomplete#sources#file#completor')
\   }))
endif

" --> asyncomplete-neosnippet.vim
if s:IS_PLUGIN_INSTALLED('asyncomplete-neosnippet.vim') && s:IS_PLUGIN_LOADED('asyncomplete-neosnippet.vim')
    call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
\    'name': 'neosnippet',
\    'whitelist': ['*'],
\    'completor': function('asyncomplete#sources#neosnippet#completor')
\   }))
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
let &backspace=join(['eol', 'indent', 'start'], ',')

let mapleader=','

nmap <leader>q :q<CR>
nmap <leader>w :w<CR>

nmap <silent> <leader>[ <C-w>h
nmap <silent> <leader>] <C-w>l

nmap <silent> <leader><CR> :let @/=''<CR>

" --> nerdtree
if s:IS_PLUGIN_INSTALLED('nerdtree') && s:IS_PLUGIN_LOADED('nerdtree')
    nmap <silent> <leader>n :NERDTreeToggle<CR>
endif

" --> tagbar
if s:IS_PLUGIN_INSTALLED('tagbar') && s:IS_PLUGIN_LOADED('tagbar')
    nmap <silent> <leader>t :TagbarToggle<CR>
endif

" --> vim-gitgutter
if s:IS_PLUGIN_INSTALLED('vim-gitgutter') && s:IS_PLUGIN_LOADED('vim-gitgutter')
    nmap <silent> <leader>g :GitGutterToggle<CR>
endif

" --> neosnippet.vim
if s:IS_PLUGIN_INSTALLED('neosnippet.vim') && s:IS_PLUGIN_LOADED('neosnippet.vim')
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
endif

" --> asyncomplete.vim
if s:IS_PLUGIN_INSTALLED('asyncomplete.vim') && s:IS_PLUGIN_LOADED('asyncomplete.vim')
    inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
