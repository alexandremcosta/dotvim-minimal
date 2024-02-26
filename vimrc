" General Settings
set autoindent          " Enable auto-indentation
set autoread            " Reload file after external program formats it
set cursorline          " Highlight cursor line
set expandtab           " Expand tabs to spaces
set hlsearch            " Highlight search results
set incsearch           " Incremental search, highlight as you type
set number              " Display line numbers
set shiftwidth=2        " Set the number of spaces to use for (auto)indent
set softtabstop=2       " Set the number of spaces a <Tab> counts for while editing
set tabstop=2           " Set the number of spaces for a tab

set statusline+=%F\ %l\:%c " Filename, line, and col on status line
set laststatus=2         " Always show status line
let g:netrw_liststyle=3  " Set netrw list style

" Colors
syntax enable
colorscheme sorbet
let $BAT_THEME='Nord'   " File preview colorscheme

" Highlight column limit at 100. Vim requires restart vim after changing this.
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%100v', 100)

" Persist undo across sessions
set undodir=~/.vim/undo
set undofile

" Use space as leader
let mapleader=" "
nnoremap <SPACE> <Nop>

" Leader mappings
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>e :Explore<CR>
nmap <Leader>g :!lazygit<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fo :History<CR>
nmap <Leader>fw :Rg<CR>
nmap <Leader>fg :silent grep

" Git Blame
nmap <Leader>b :vert term git blame -- %<CR>

" Save with sudo
command W :execute ':silent w !sudo tee % > /dev/null' \| :edit!
nmap <Leader>W :W<CR>

" Terminal
nmap <c-t> :terminal<CR>
nmap <s-t> :vertical terminal<CR>

" Split navigation
nmap <bar> :vsplit<CR>
nmap \ :split<CR>
nmap <silent> <c-h> <c-w>h
nmap <silent> <c-j> <c-w>j
nmap <silent> <c-k> <c-w>k
nmap <silent> <c-l> <c-w>l

" Resize
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" Quickfix Navigation
nmap <silent> [q :cprevious<CR>
nmap <silent> ]q :cnext<CR>

" ALE
nmap gd :ALEGoToDefinition<CR>
nmap <s-k> :ALEHover<CR>
let g:ale_floating_preview = 1
let g:ale_hover_cursor = 0
let g:ale_history_enabled = 1
let g:ale_history_log_output = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_fix_on_save = 1
let g:ale_linters = {'elixir': ['lexical', 'mix', 'dialyxir', 'credo']}
let g:ale_elixir_lexical_release = '/users/alex/dev/clones/lexical/_build/dev/package/lexical/bin'
let g:ale_completion_enabled = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'elixir': ['mix_format']}

" Automatically open the quickfix window after :make, :grep, :lvimgrep
augroup openquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Return to last edit position when opening files
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Use ripgrep on :grep if available
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" OS-specific Settings
let g:os = substitute(system('uname'), '\n', '', '')

if g:os == "Darwin"
  set ttyfast " Send more characters for redraws
  set mouse=a " Enable mouse use in all modes
  set clipboard+=unnamed " Clipboard on OSX with cmd + c or v
else
  vmap <Leader>c y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
  nmap <Leader>v :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
  set ttymouse=xterm2 " Mouse on Linux
endif

" Elixir Run Mix Test
let s:term_buf_nr = -1

function! s:MixTest(command) abort
    if s:term_buf_nr != -1
        try
            execute "bdelete! " . s:term_buf_nr
        catch
        endtry
        let s:term_buf_nr = -1
    else
        execute 'terminal mix test % ' . a:command
        set nonu cc= " Remove numbers and colorcolumn
        resize -15
        wincmd w " Move back to the last split pane
        let s:term_buf_nr = bufnr("$")
    endif
endfunction

nmap <silent> <Leader>t :call <SID>MixTest("--exclude test --include line:" . line('.'))<CR>zz
tmap <silent> <Leader>t <C-w>N:call <SID>MixTest("--exclude test --include line:" . line('.'))<CR>zz
nmap <silent> <Leader>T :call <SID>MixTest("--include integration")<CR>zz
tmap <silent> <Leader>T <C-w>N:call <SID>MixTest("--include integration")<CR>zz

" Elixir snippet to append inspect to the end of a line
nmap <Leader>i i\|> IO.inspect(label: "")<ESC>hi
