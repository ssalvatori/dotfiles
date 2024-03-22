

## Setup

Clone repository
```
git clone --recursive https://github.com/ssalvatori/dotfiles.git ~/.dotfiles
```

Install Brew

```
export NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Brew's bundle module
```
brew bundle --file ~/.dotfiles/Brewfile
```

Set zsh as default shell
```
chsh -s $(which zsh)
```

Install Oh-My-Zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

Copy zshrc configuration
```
rm -rf ~/.zshrc && ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```


Copy tmux configuration
```
mkdir -p ~/bin ~/.config/tmux
ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s ~/.dotfiles/bin/tmux-cht.sh ~/bin/tmux-cht.sh
```

### Mac Settings


```
cd ~/.dotfiles/
chmod +x ./scripts/custom-setup.sh ./scripts/final-setup.sh
./scripts/custom-setup.sh && ./scripts/final-setup.sh
```


### Todo
