#Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# wsl stuff
export BROWSER=wslview
export LIBGL_ALWAYS_INDIRECT=1


# Note: I think this breaks things even more?
# export DISPLAY="$(ip route list default | awk '{print $3}'):0"
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0

# enable docker proress to always be plain text
#
export BUILDKIT_PROGRESS=plain

# Add nvim bin to path
export PATH="$PATH:/opt/nvim-linux64/bin"

export XDG_CONFIG_HOME="/root/.config/"

# Java stuff
export PATH="$PATH:~/.m2/"

# Set Theme name
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# set to "random" to use a random theme
# run to view theme: echo $RANDOM_THEME
ZSH_THEME="refined"

# set to auto update
zstyle ':omz:update' mode auto      

# set to check every day
zstyle ':omz:update' frequency 1 

# set NVM environment and enable bash completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Configure lua enviorment
export LUA_LS_PATH="$HOME/tools/lua-language-server/bin"
export PATH=$PATH:$LUA_LS_PATH
alias lua-language-server="$HOME/tools/lua-language-server/bin/lua-language-server"

# Teleport commands
alias tlptDev="tsh ssh nicholas.judge@feb2c45c-4989-4987-9fd1-d591ebed7355"

# Configure Go environment
# GOPATH MUST BE OUTSIDE OF GOROOT directory!!!
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GOROOT=/usr/local/go
export GOPATH=/home/nicholas.judge/goPackages
export PATH=$PATH:/usr/local/go/bin

# Configure Rust
# Cargo's bin directory ($HOME/.cargo/bin)
export PATH="$HOME/.cargo/bin:$PATH"

# try and get tab completion back
autoload -Uz compinit && compinit

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

# tmux + tmux completions
# set tmux to launch on zsh startup
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# Set default dotnet root
export DOTNET_ROOT="$HOME/.dotnet"
export PATH=$PATH:$DOTNET_ROOT

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")
  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi
  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}
compdef _dotnet_zsh_complete dotnet

# clean apt/old package stuff
alias purgeApt="sudo apt autoremove && sudo apt clean"
alias purgeDocker="docker system prune -af --volumes"
alias purgeJetbrainsCache="sudo rm -rf ~/.cache/JetBrains/*"
alias distUpdate="sudo apt update && sudo apt upgrade -y"


# Get storage info
alias showFreeSpace="df -Th | grep -v fs"
alias showLargeFiles="sudo find / -size +1G"
alias showFolderBreakdown="sudo du -x -h -d1 /"

# copy tracking replay logs to local
alias switchToDevEks="kubectl config set-context arn:aws:eks:us-east-2:648679051309:cluster/dev-shareasale-us-east-2-cluster"
alias switchToProdEks="kubectl config set-context prod-shareasale-us-east-2-cluster"
alias copyReplayLogs="kubectl cp admin-transfer-files:app/logs ~/solutions/tracking/replayLogs -n tracking"

# remap dotnet commands to shorter ones
alias db="dotnet build"
alias dr="dotnet run"
alias drp="dotnet run --project"
alias dt="dotnet test"
alias dtf="dotnet test --filter"
alias dc="dotnet clean"
alias dp="dotnet publish"
alias whatEnv="echo $ASPNETCORE_ENVIRONMENT"
alias addAllToSln="dotnet sln add **/*.csproj"
alias dnewsol="dotnet new sln -n "

alias devEnv="source ~/solutions/envFiles/dev.env"
alias prodEnv="source ~/solutions/envFiles/prod.env"
alias editEnv="nvim ~/solutions/envFiles/."

# tmux
alias cls="clear"
alias tmuxReload="tmux source  ~/.config/tmux/tmux.conf"
alias tmuxNew="tmux new -s"
alias tmuxAttach="tmux attach -t"
alias tmuxList="tmux list-sessions"
alias tmuxKill="tmux kill-session -t"

# See open used ports
alias seePorts="sudo lsof -i -P -n | grep LISTEN"

# docker 
alias startDocker="sudo systemctl start docker;sudo service docker start"
#alias dockerFullUninstall="for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done"

# git shortcuts
alias gdiff="git difftool --tool vimdiff"
alias gcheck="git checkout -b "
alias gpush="git push"
alias gp="git push"
alias gpull="git pull"
alias gpu="git pull"
alias gadd="git add ."
alias ga="git add ."
alias gct="git commit -m "

# Build + restore .net commands
alias clearNuget="rm -r ~/.nuget/packages"

# apt shortcuts
alias searchApt="apt search --names-only"
alias listInstalled="apt list --installed"
alias install="sudo apt-get install"
alias upg="sudo apt-get update; sudo apt-get upgrade"
alias remove="sudo apt-get remove"
alias autoremove="sudo apt-get autoremove"

# ZSH shortcuts
alias zshrc="nvim ~/.zshrc"
alias reloadZsh="source ~/.zshrc"
alias listAliases="cat ~/.zshrc | grep 'alias'"

# Fixing existing commands to throw good flags
alias mv="mv -v"
alias ln="ln -v"
alias cp="cp -v"
alias rm="rm -v"
alias ls="ls --group-directories-first --color=always"
alias ls-A="ls -a --group-directories-first --dereference-command-line-symlink-to-dir --color=auto"
alias ll="ls --dereference-command-line-symlink-to-dir -lh"
alias l="ls -la --dereference-command-line-symlink-to-dir"
alias info='info --vi-keys --init-file=${XDG_CONFIG_HOME}/infokey'
alias pgrep="pgrep -l"
alias grep="grep -i --color=auto"
alias egrep="egrep --color=auto"
alias ip="ip addr"

# folder shortcuts
alias configFolder="cd ~/.config"
alias sol="cd ~/solutions"
alias tools="cd ~/tools"

# awin auth
alias awinDockerLogin="cat ~/solutions/envFiles/dockerCredentials.txt | docker login -u nicholas.judge registry.awin.com --password-stdin"
alias awinAwsLogin="/root/solutions/CloudOps/aws-systemsengineering/utils/sso/wslPatch.sh -a -u nicholas.judge"
alias awinFullLogin="awinDockerLogin;awinAwsLogin"

# Awin testing
alias awinCurlPrivate="timeout 3 curl -o /dev/null -s -w "%{http_code}\n" https://awin.com"
alias awinCurlPublic="timeout 3 curl -o /dev/null -s -w "%{http_code}\n" https://registry.awin.com"
alias awinDevToken="curl http://ui.d-lhr1-docker-020.dev.awin.com/idpbackend/token -d 'grant_type=client_credentials&client_id=migrationTestClient&client_secret=$AWIN_SPRINGFIELD_STAGING_CLIENT_SECRET'"
alias awinStagingToken="curl http://ui.staging.awin.com/idpbackend/token -d 'grant_type=client_credentials&client_id=migrationTestClient&client_secret=$AWIN_SPRINGFIELD_DEV_CLIENT_SECRET'"
