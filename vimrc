" General Settings
syntax enable
set autoindent          " Enable auto-indentation
set autoread            " Reload file after external program formats it
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

" Leader mappings
let mapleader=" "
nnoremap <SPACE> <Nop>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>e :Explore<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fo :History<CR>
nmap <Leader>fw :Rg<CR>
nmap <Leader>fg :silent grep
nmap gd :ALEGoToDefinition<CR>
nmap <s-k> :ALEHover<CR>
nmap <bar> :vsplit<CR>
nmap \ :split<CR>

" ALE Configuration
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

" Quickfix Navigation
nmap <silent> [q :cprevious<CR>
nmap <silent> ]q :cnext<CR>

" Automatically open the quickfix window after :make, :grep, :lvimgrep
augroup openquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

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

nnoremap <silent> <Leader>t :call <SID>MixTest("--exclude test --include line:" . line('.'))<CR>zz
tnoremap <silent> <Leader>t <C-w>N:call <SID>MixTest("--exclude test --include line:" . line('.'))<CR>zz

nnoremap <silent> <Leader>T :call <SID>MixTest("--include integration")<CR>zz
tnoremap <silent> <Leader>T <C-w>N:call <SID>MixTest("--include integration")<CR>zz

" Elixir snippet to inspect
nmap <Leader>i i\|> IO.inspect(label: "")<ESC>hi
imap <Leader>i \|> IO.inspect(label: "")<ESC>hi
