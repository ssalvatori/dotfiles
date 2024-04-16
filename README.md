# Dotfiles

## Setup

Clone repository

```bash
git clone --recursive https://github.com/ssalvatori/dotfiles.git ~/.dotfiles
```

Install Brew

```bash
export NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Brew's bundle module

```bash
brew bundle --file ~/.dotfiles/Brewfile
```

Set zsh as default shell

```bash
chsh -s $(which zsh)
```

Install Oh-My-Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

Copy zshrc configuration

```bash
rm -rf ~/.zshrc && ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

Copy tmux configuration

```bash
mkdir -p ~/bin ~/.config/tmux
ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s ~/.dotfiles/bin/tmux-cht.sh ~/bin/tmux-cht.sh
```

Wezterm configuration

```bash
ln -s ~/.dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
```

Visual Studio Code
```bash
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

### Mac Settings

```bash
cd ~/.dotfiles/
chmod +x ./scripts/custom-setup.sh ./scripts/final-setup.sh
./scripts/custom-setup.sh && ./scripts/final-setup.sh
```

## TODO

* Create a single script to configure everything
