



# basile.nvim - Neovim config

My personal Neovim config, written in Lua. Tailored specifically to my needs, but feel free to use it as a base for your own config.


## Features

### AI with `avante.nvim`

[`avante.nvim`](https://github.com/yetone/avante.nvim) is a Neovim plugin made to provide a more intelligent completion experience. It provides a more intelligent completion experience by using AI models to predict the next word. It is heavily inspired by the Cursor IDE and offers similar features.


### Neorg

[Neorg](https://github.com/nvim-neorg/neorg) is a note-taking plugin for Neovim. It allows you to create and manage notes in a simple and organized way. I also use it for literate programming, which I used for my [`tmux` config](https://github.com/davidbasilefilho/basile.tmux), for example.


### LSP, Treesitter, and more

It includes a lot of features like LSP, Treesitter, diagnostics, debugging, and more.


## Dependencies

- Neovim 0.10.0 or higher is recommended.
- `git`, `make`, `unzip`, `gcc`.
- `ripgrep`.
- A clipboard tool (`xclip`, `xsel`, `win32yank` or other depending on the platform).
- A [Nerd Font](https://www.nerdfonts.com/) for the icons, I use Geist Mono.
- `luarocks` for Neorg.
- `tmux` for the integration with it.


## Installation

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/davidbasilefilho/basile.nvim.git ~/.config/nvim && nvim
```
