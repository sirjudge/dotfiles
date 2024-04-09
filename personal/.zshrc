# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fletcherm"

# Set oh my zsh to auto update every 1 day
zstyle ':omz:update' mode auto      
zstyle ':omz:update' frequency 1

#GOPATH MUST BE OUTSIDE OF GOROOT directory!!!
export GO111MODULE=on
export GOROOT=/usr/lib/go-1.18
export GOPATH=/home/nico/goPackages
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# set tmux to launch on zsh startup
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# Load plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Tmux
alias tmuxReload="tmux source  ~/.config/tmux/tmux.conf"
alias tmuxNew="tmux new -s"
alias tmuxAttach="tmux attach -t"
alias tmuxList="tmux list-sessions"
alias tmuxKill="tmux kill-session -t"

# remap clear to cls because I am lazy
alias cls="clear"

# SSH commands
alias homelab="ssh nico@192.168.1.34"   

# screenshotting
alias screenshotSelect="scrot -s --file '/home/nico/Pictures/Screenshots/%Y-%m-%d_$wx$h_scrot.png'"

# set brightness commands
alias lowBrightness="sudo brightnessctl --min-val=2 set 2%"
alias maxBrightness="sudo brightnessctl --min-val=2 set 100%"

# set monitor commands
alias officeMonitor="xrandr --output eDP-1-1 --auto --output DP-0 --primary --auto --left-of eDP-1-1;" 
alias officeDualMonitors="~/Tools/scripts/DualOfficeMonitor.sh"
alias bedroomMonitor="xrandr --output eDP-1-1 --mode 1920x1080 --output HDMI-0 --primary --mode 1920x1080 --right-of eDP-1-1 "

# remap vim to nvim because I type both
alias vim="nvim"

# apt shortcuts
alias upg="sudo apt-get update; sudo apt-get upgrade; sudo flatpak update"
alias search="apt search"
alias install="sudo apt install"

# ZSH
alias zshrc="nvim ~/.zshrc"
alias reloadZsh="source ~/.zshrc"
alias listAliases="cat ~/.zshrc | grep 'alias'"

# Fixing existing commands to throw good flags
alias mv="mv -v"
alias ln="ln -v"
alias cp="cp -v"
alias rm="rm -v"
alias ls="ls -a --group-directories-first --dereference-command-line-symlink-to-dir --color=auto"
alias ll="ls --dereference-command-line-symlink-to-dir -lh"
alias l="ls -la --dereference-command-line-symlink-to-dir"
alias info='info --vi-keys --init-file=${XDG_CONFIG_HOME}/infokey'
alias pgrep="pgrep -l"
alias grep="grep -i --color=auto"
alias egrep="egrep --color=auto"
alias ip="ip addr"

# directory shortcuts
alias solutions="cd ~/solutions"
alias sol="cd ~/solutions"
alias configFolder="cd ~/.config"
alias tools="cd ~/Tools"
alias dataComp="cd ~/solutions/data_comparison_tool"
alias nicojudge="cd ~/solutions/nicojudge"

alias dotnet="~/.dotnet/dotnet"

# bun completions
[ -s "/home/nico/.bun/_bun" ] && source "/home/nico/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
