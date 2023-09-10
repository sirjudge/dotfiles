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
ZSH_THEME="darkblood"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

#GOPATH MUST BE OUTSIDE OF GOROOT directory!!!
export GO111MODULE=on
export GOROOT=/usr/lib/go-1.18
export GOPATH=/home/nico/goPackages
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# dotnet and dotnet accessories
alias nugetRestore="nuget restore -ConfigFile ~/.config/NuGet/nuget.config"
alias buildFramework="msbuild -r -nologo -p:Configuration=Release -t:Clean,Build "
alias buildCore="dotnet build"
alias testCore="dotnet test"

# yum shortcuts
alias install="sudo yum install"
alias upg="sudo yum update; sudo yum upgrade;"
alias remove="sudo yum remove"
alias listPkg="sudo yum list installed"
alias searchInstalledPackage="sudo yum list installed | grep"
alias packageCount="sudo yum list installed | wc -l"
alias backUpInstalledPackages="sudo yum list installed > ~/Archives/packageBackup_$(date +%Y-%m-%d_%H:%M).txt"

# apt shortcuts
alias upg="sudo apt-get update; sudo apt-get upgrade"
alias search="apt search"
alias install="sudo apt install"
# ZSH fun
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

# remap nvim to latest version of app image
# alias nvim="~/tools/nvim.appimage"

# directory shortcuts
alias solutions="cd ~/solutions"
alias compliance="cd ~/solutions/compliance"
alias neovimConfig="cd ~/.config/nvim"
alias configFolder="cd ~/.config"
alias discovery="cd ~/solutions/discovery"
alias messaging="cd ~/solutions/messaging"
alias tooling="cd ~/solutions/tooling"

# build and test shortcuts
alias netRestore="dotnet restore --configfile ~/.config/NuGet/nuget.config"
alias netTest="dotnet test"
alias goBuild="go build -o main ."
alias goRun="go run ."
alias goTest="go test -v"

# dotnet tooling
alias envConfigSetDev="~/solutions/tooling/environmentconfigurator/ShareASale.EnvironmentConfigurationTool/bin/Debug/net7.0/ShareASale.EnvironmentConfigurationTool SetEnvironment=dev"
alias envConfigSetProd="~/solutions/tooling/environmentconfigurator/ShareASale.EnvironmentConfigurationTool/bin/Debug/net7.0/ShareASale.EnvironmentConfigurationTool SetEnvironment=prod"

export PATH=$PATH:"~/solutions/tooling/environmentconfigurator/ShareASale.EnvironmentConfigurationTool/bin/Debug/net7.0/"

# Nunit tests
alias monoTest="mono ~/tools/NuGet/NUnit.ConsoleRunner.3.12.0/tools/nunit3-console.exe"
alias testMessaging="monoTest /home/nicholas.judge/solutions/messaging/shareasale.notifications/MessageQueuerTests/bin/Release/MessageQueuerTests.dll"

# bun completions
[ -s "/home/nico/.bun/_bun" ] && source "/home/nico/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
