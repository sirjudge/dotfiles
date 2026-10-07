# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Add niri completions
# source ~/.config/zsh/niriCompletions.zsh    

# Rose Pine theme
source ~/.config/zsh/rose-pine-zsh/rose-pine-zsh.zsh
colorize_zsh rose-pine-moon

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Auto update every day
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi


# Dotnet stuff
export DOTNET_ROOT=/usr/share/dotnet
export DOTNET_ROOT_X64=/usr/share/dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="$PATH:/home/nico/.dotnet/tools"
# export DOTNET_INSTALL_DIR=/home/nico/.dotnet/
# Old paths when I used the dotnet script instead of pacman
# export PATH="$PATH:/home/nico/.dotnet/tools"
# export PATH="$PATH:/home/nico/.dotnet/"

# Node stuff
export PATH="$HOME/.npm-global/bin:$PATH"

# Vintage Story
export VINTAGE_STORY="/opt/vintagestory"
export VINTAGE_STORY_DATA="/home/nico/.config/VintagestoryData"

# Pacman and Aur
alias upg="sudo pacman -Syu;yay -Syu"
alias pacIn="sudo pacman -S"
alias pacUn="sudo pacman -R"
alias yayIn="yay -S"
alias yayUn="yay -R"

# Files and Folders
alias mv="mv -v"
alias ln="ln -v"
alias cp="cp -v"
alias cpr="cp -r"
alias rm="rm -v"
alias ls="ls -a --group-directories-first --dereference-command-line-symlink-to-dir --color=auto"
alias ll="ls --dereference-command-line-symlink-to-dir -lh"
alias l="ls -la --dereference-command-line-symlink-to-dir"
alias info="info --vi-keys --init-file=$XDG_CONFIG_HOME/infokey"
alias pgrep="pgrep -l"
alias grep="grep -i --color=auto"
alias egrep="egrep --color=auto"

# Tmux
if [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi
alias tmuxNew="tmux new -s"
alias tmuxAttach="tmux attach -t"
alias tmuxList="tmux list-sessions"
alias tmuxKill="tmux kill-session -t"

# remap clear to cls because I am lazy
alias c="clear"

# SSH commands
alias homelab="ssh nico@192.168.1.34"

# set brightness commands
alias lowBrightness="sudo brightnessctl --min-val=2 set 2%"
alias maxBrightness="sudo brightnessctl --min-val=2 set 100%"

# ZSH
alias listAliases="grep 'alias' ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias rz="source ~/.zshrc"

alias lo="wlogout --protocol layer-shell"
alias ff="fastfetch"

alias gpuRenderList="ls -l /dev/dri/by-path/*-render"
alias gpuPciList="lspci -s 00:02.0; lspci -s 01:00.0"

eval "$(zoxide init zsh)"
export PATH="$HOME/.local/bin:$PATH"


# Load Angular CLI autocompletion.
source <(ng completion script)
