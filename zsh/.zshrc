export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:/usr/local/opt/curl/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="clean"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"


# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

export HISTFILE=$HOME/.zsh_history
# Set the history size to 2000 commands
export HISTSIZE=20000
# Store the same number to disk
export SAVEHIST=$HISTSIZE
# Share history between sessions
setopt share_history
# Remove duplicates first when HISTSIZE is met
setopt hist_expire_dups_first
# If a command is issued multiple times in a row, ignore dupes
setopt hist_ignore_dups
# Allow editing the command before executing again
setopt hist_verify
# Do not add commands prefixed with a space to the history
setopt hist_ignore_space

# TMUX setup
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true

plugins=(git terraform fzf tmux)

source $ZSH/oh-my-zsh.sh

# history configuration


export EDITOR="nvim"
export GIT_EDITOR="nvim"

export HIST_STAMPS="yyyy-mm-dd"

export XDG_CONFIG_HOME=$HOME/.config/

# FZF specific - https://github.com/junegunn/fzf#key-bindings-for-command-line
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"
export FZF_DEFAULT_OPTS="--height 75% --layout=reverse --border"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="fd --type d . --color=never"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

export TFLINT_CONFIG_FILE="$HOME/.dotfiles/tflint/tflint.hcl"

bindkey -s ^f "~/.local/bin/tmux-sessionizer\n"

## Load aliases
source ~/.zshrc_alias

eval "$(fzf --zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
