

## Setup

Clone repository
```
git clone https://github.com/ssalvatori/dotfiles.git ~/.dotfiles
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


Diable tags in finder
```
defaults write com.apple.Finder ShowRecentTags -bool false
```

Change default new windows
```
defaults write com.apple.Finder NewWindowTargetPath -string "file://${HOME}/"
```

Disable hot corners
```
defaults write com.apple.dock wvous-tl-corner -int 0
```

Disable top right Hot Corner:

```
defaults write com.apple.dock wvous-tr-corner -int 0
```

Disable bottom left Hot Corner:

```
defaults write com.apple.dock wvous-bl-corner -int 0
```

Disable bottom right Hot Corner:

```
defaults write com.apple.dock wvous-br-corner -int 0
```

```
defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
```
