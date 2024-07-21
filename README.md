
# Minimalistic Development Environment

## Setup

You need to install the following tools: `git`, `clang`, and `cmake`.

Use your preferred package manager. For example, on Arch Linux:

```bash
sudo pacman -S git clang cmake
```

Next, clone the repository:

Using SSH:
```bash
git clone git@github.com:QwistyS/dev_env.git
```

Using HTTPS:
```bash
git clone https://github.com/QwistyS/dev_env.git
```

## Fonts

For a great development experience, I recommend using the Cousine Nerd Font. Here’s a simple installation guide:

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Cousine.zip
unzip Cousine.zip
fc-cache -fv
```

## Terminal

I prefer using Alacritty for its straightforward configuration and performance.

Install Alacritty as you prefer, but check the official [Alacritty releases](https://github.com/alacritty/alacritty/releases) for the latest version.

To configure Alacritty:
```bash
cd dev_env
cp alacritty/alacritty.toml ${XDG_CONFIG_HOME:-$HOME/.config}/alacritty
```

## Tmux

Check the latest version of tmux on its [release page](https://github.com/tmux/tmux/releases) and install it as you prefer.

### Tmux Plugin Manager (TPM)

Install TPM for managing tmux plugins:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Copy the tmux configuration:
```bash
cd dev_env/tmux
cp .tmux.conf $HOME
```

## Editor

I use Neovim because it's comfortable and suits my development style.

### Neovim Installation

Navigate to the [Neovim GitHub page](https://github.com/neovim/neovim) and get the latest release. You can install it from source or use a pre-built release.

I use [NvChad](https://github.com/NvChad/NvChad) as my Neovim configuration. It's easy and simple. Follow the [NvChad Documentation](https://nvchad.com/docs/quickstart/install/) for installation.

Copy the Neovim configuration:
```bash
cd dev_env
cp -r nvim ${XDG_CONFIG_HOME:-$HOME/.config}
```

Install necessary tools like `luarocks` and `lua 5.1+`.

Run Neovim:
```bash
nvim
```

Then run:
```vim
:MasonInstallAll
```

You are done with Neovim setup.

## Tools

### vimcs

vimcs is a cheatsheet for Vim. I suggest moving it to `/usr/local/bin` for easy access. Resolve any dependencies before using it.

### bella

bella is an assistant that provides formatted, code-oriented responses. You’ll need to add your OpenAI API key to your shell configuration file (`.bashrc`, `.zshrc`, etc.):

Add this line to the bottom of your shell configuration file:
```sh
export OPENAI_API_KEY="your_openai_api_key"
```

### Useful Aliases

Add these aliases to your shell configuration file for convenience:
```sh
alias ll='ls -al'
alias btop='btop --utf-force'
alias vim='nvim'
```

### btop

btop is a great C++ based GPU monitoring tool, similar to `top` or `htop`. Check it out and give it a star on GitHub.
