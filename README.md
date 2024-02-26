## Installation

	git clone git://github.com/alexandremcosta/dotvim-minimal.git ~/.vim

	ln -s ~/.vim/vimrc ~/.vimrc
	cd ~/.vim
	git submodule init
	git submodule update

## Features

- Filename, col and rol on statusline
- Mouse support on OSX and Linux
- Cut/copy/paste support to system clipboard using vim commands on OSX `d, D, y, Y, p, P`
- Copy/paste support to system clipboard on Linux `<Leader>c` or `<Leader>v`
- Return to last edit position when opening files
- Navigate split panels in normal mode with `Ctrl` + `hjkl`
- Use `:SudoW` to write (save) file with sudo
- Elixir support: lexical, credo, dialyzer, `mix format` on save
- Elixir language server:
    * go to function definition `gd`
    * go back `<Ctrl-o>`
    * hover function docs `shift-k`

## Other Keyboard Mappings
Install ripgrep and fzf for full functionality.
`<Leader>` key is the space-bar.

| Feature | Keyboard Mapping |
|---|---|
| Vertical split | `|` |
| Horizontal split | `\` |
| File explorer | `<Leader>e` |
| Find word with fzf and rg | `<Leader>fw` |
| Find file with fzf and rg | `<Leader>ff` |
| On `fzf`, open file in **split** pane | `<Ctrl-x>` |
| On `fzf`, open file in **vertical** split pane | `<Ctrl-v>` |
| Git blame current line | `<Leader>b` |
| Run elixir **test** under cursor | `<Leader>t` |
| Run all elixir **tests** on current file | `<Leader>T` |
| Paste `IO.inspect(label: "")` leaving cursor between quotes | `<Leader>i` |

## Add plugin
For example, the famous git plugin: `vim-fugitive`

	cd ~/.vim
	git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
	git add .
	git commit -m "Install Fugitive.vim bundle as a submodule."

## Remove plugin
To remove a plugin named `foo`

	cd ~/.vim
	git submodule deinit pack/plugins/start/foo
	git rm -r pack/plugins/start/foo
	rm -r .git/modules/pack/plugins/start/foo
