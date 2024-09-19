# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="essembeh"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git terraform direnv fzf golang vagrant)

source $ZSH/oh-my-zsh.sh

# history configuration

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

export EDITOR="nvim"
export GIT_EDITOR="nvim"
export PATH="$HOME/bin:/usr/local/opt/curl/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/.bin:$PATH"

export HIST_STAMPS="yyyy-mm-dd"

export XDG_CONFIG_HOME=$HOME/.config/

# FZF specific - https://github.com/junegunn/fzf#key-bindings-for-command-line
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"
export FZF_DEFAULT_OPTS="--height 75% --layout=reverse --border"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="fd --type d . --color=never"

if [[ "$TMUX" ]]; then
    function lv() {
        tmux split-window -h less "$@"
    }
    function ev() {
        tmux split-window -h vim "$@"
    }
    function lh() {
        tmux split-window -v less "$@"
    }
    function eh() {
        tmux split-window -v vim "$@"
    }
fi

function prompt_dir() {
  prompt_segment blue $CURRENT_FG '%2~'
}


export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

export TFLINT_CONFIG_FILE="$HOME/.dotfiles/tflint/tflint.hcl"

## Load aliases
source ~/.zshrc_alias

eval "$(fzf --zsh)"
