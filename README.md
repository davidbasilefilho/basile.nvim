



# basile.nvim - Neovim config

My personal Neovim config, written in Lua. Tailored specifically to my needs, but feel free to use it as a base for your own config.

## Features

This configuration is built upon a set of plugins that enhance the Neovim experience. Here are some of the key features:

### AI-Powered Development

- **`avante.nvim`**: Inspired by Cursor IDE, this plugin provides an intelligent completion experience.
- **`gemini-cli.lua`**: A plugin for interacting with the Gemini CLI.
- **`blink-cmp-copilot.lua`**: Integrates Github Copilot into the completion menu.

### Modern Editing Experience

- **`mini.lua`**: A collection of minimal, fast, and feature-rich plugins.
- **`flash.lua`**: Enhances navigation with quick jumps to any position in the buffer.
- **`gitsigns.lua`**: Adds git decorations to the sign column.
- **`vim-tmux-navigator`**: Seamless navigation between Neovim splits and Tmux panes.

### Language Support and Tooling

- **LSP & Treesitter**: Full support for Language Server Protocol and Treesitter for syntax highlighting, code analysis, and more.
- **Formatting and Linting**: `conform.lua` and `lint.lua` ensure consistent code style and quality.
- **Debugging**: Integrated debugging support with `debug.lua`.

## Showcase

Images demonstrating the config:

![Dashboard](https://raw.githubusercontent.com/davidbasilefilho/basile.nvim/refs/heads/main/img/dashboard.png)
*Dashboard*

![Lua](https://raw.githubusercontent.com/davidbasilefilho/basile.nvim/refs/heads/main/img/lua.png)
*Editing Lua file*

![Avante Chat](https://raw.githubusercontent.com/davidbasilefilho/basile.nvim/refs/heads/main/img/avante-chat.png)
*AI Chat*

![Tmux with neovim](https://raw.githubusercontent.com/davidbasilefilho/basile.nvim/refs/heads/main/img/tmux-nvim.png)
*Tmux with neovim*

## Dependencies

- Neovim 0.10.0 or higher is recommended.
- `git`, `make`, `unzip`, `gcc`.
- `ripgrep`.
- A clipboard tool (`xclip`, `xsel`, `win32yank` or other depending on the platform).
- A [Nerd Font](https://www.nerdfonts.com/) for the icons, I use Geist Mono.
- `tmux` for the integration with it.

## Installation

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/davidbasilefilho/basile.nvim.git ~/.config/nvim && nvim
```

## Special thanks

- TJ DeVries and the [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim) project.
- The Primeagen and [his neovim config](https://github.com/ThePrimeagen/init.lua)
