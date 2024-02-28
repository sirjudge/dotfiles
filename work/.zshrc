#Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Configure Go environment
# GOPATH MUST BE OUTSIDE OF GOROOT directory!!!
#export GO111MODULE=on
export GOROOT=/usr/lib/go
export GOPATH=/home/nicholas.judge/goPackages
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Configure Rust
#Cargo's bin directory ($HOME/.cargo/bin)
export PATH="$HOME/.cargo/bin:$PATH"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# See open used ports
alias seePorts="sudo lsof -i -P -n | grep LISTEN"

# local smtp servers
alias smtp4DevBinary="sudo ~/tools/smtp4Dev/Rnwood.Smtp4dev"
alias smtp4DevDocker="sudo docker run --rm -it -p 3000:80 -p 2525:25 rnwood/smtp4dev"
alias mailTrap="sudo docker container run -d --rm -it --init --name=mailtrap -p 127.0.0.1:9080:80 -p 127.0.0.1:9025:25 dbck/mailtrap"
alias mailTrapAllPorts="sudo docker container run -d --rm --init --name=mailtrap -p 127.0.0.1:9080:80 -p 127.0.0.1:9025:25 -p 127.0.0.1:9587:587 -p 127.0.0.1:9143:143 dbck/mailtrap"
alias stopMailTrap="sudo docker stop mailtrap"
alias bytemarkSmtp="sudo docker run --restart always --name mailing -p 25:25 -d bytemark/smtp"

#remap neovim to the appimage
alias nvim="~/tools/nvim.appimage"

#remap to jetbrains toolbox
alias jetbrains="~/tools/jetbrains-toolbox/jetbrains-toolbox"
alias clearRiderCache="sudo rm -r ~/.cache/JetBrains/Rider*"

# docker 
alias startDocker="sudo systemctl start docker;sudo service docker start"

# git shortcuts
alias gdiff="git difftool --tool vimdiff"
alias gcheck="git checkout -b "
alias gpush="git push"
alias gpull="git pull"
alias gadd="git add ."
alias gcommit="git commit -m "

# copilot shortcuts
alias copilotSuggest="gh suggest "

# Build + restore .net commands
alias clearNuget="rm -r ~/.nuget/packages"
alias dotnetRestore="dotnet restore --configfile ~/.config/NuGet/nuget.config"
alias nugetRestore="nuget restore -ConfigFile ~/.config/NuGet/nuget.config"
alias FrameworkBuild="msbuild -r -nologo -p:Configuration=Release -t:Clean,Build "
alias coreBuild="dotnet build --configfile ~/.config/NuGet/nuget.config"
alias coreRestore="dotnet restore --configfile ~/.config/NuGet/nuget.config"
alias coreTest="dotnet test --no-build"
alias coreFullSuite="coreRestore ;coreBuild; coreTest"

# Specific testing commands
alias loggerDDTests="dotnet test --no-build --filter DataDogTests"
alias loggerUtilityTests="dotnet test --no-build --filter UtilityTests"

# build and test shortcuts
alias goBuild="go build -o main ."
alias goRun="go run ."
alias goTest="go test -v"

# apt shortcuts
alias searchApt="apt search --names-only"
alias listInstalled="apt list --installed"
alias install="sudo apt-get install"
alias upg="sudo apt-get update; sudo apt-get upgrade"
alias remove="sudo apt-get remove"

# ZSH shortcuts
alias zshrc="nvim ~/.zshrc"
alias update="sudo yum update; sudo yum upgrade;"
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

# directory shortcuts
alias solutions="cd ~/solutions"
alias compliance="cd ~/solutions/compliance"
alias finance="cd ~/solutions/finance"
alias neovimConfig="cd ~/.config/nvim"
alias configFolder="cd ~/.config"
alias messaging="cd ~/solutions/messaging"
alias tools="cd ~/tools"
alias nugetFolder="cd ~/solutions/NuGet/"

# Envionment Configuration
alias envConfigSetDev="~/solutions/tooling/environmentconfigurator/ShareASale.EnvironmentConfigurationTool/bin/Debug/net8.0/ShareASale.EnvironmentConfigurationTool SetEnvironment=dev"
alias envConfigSetProd="~/solutions/tooling/environmentconfigurator/ShareASale.EnvironmentConfigurationTool/bin/Debug/net8.0/ShareASale.EnvironmentConfigurationTool SetEnvironment=prod"
alias envConfigUi="dotnet run --project ~/solutions/tooling/environmentconfigurator/EnvironmentConfigurationUi/EnvironmentConfigurationUi.csproj"
export PATH=$PATH:"~/solutions/tooling/environmentconfigurator/EnvironmentConfigurationTool/bin/Debug/net8.0/"

# bun + bun completions
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/nicholas.judge/.bun/_bun" ] && source "/home/nicholas.judge/.bun/_bun"
