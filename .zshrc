# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="darkblood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
# COMPLETION_WAITING_DOTS="true"

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Alias
#Zsh Stuff
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# package manager
alias upg="sudo apt-get update; sudo apt-get upgrade"
alias checkaptcache="sudo du -sh /var/cache/apt/archives"
alias clearaptcache="sudo apt-get clean"
alias search="apt search --names-only"
alias install="sudo apt-get install"
alias autoremove="sudo apt autoremove"

# Nvidia Stuff
alias launchWithGpu="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

#LaunchMusic
alias quboz="flatpak run eu.tiliado.NuvolaAppQobuz"
alias youtubeMusic="flatpak run eu.tiliado.NuvolaAppYoutubeMusic"

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
alias reloadzsh="source ~/.zshrc"
alias ip="ip addr"

#brightness
alias bup=" sudo brightnessctl --min-val=2 -q set 5%+"
alias bdown=" sudo brightnessctl --min-val=2 -q set 5%-"

#Applications
alias wstorm="~/Documents/applications/WebStorm/bin/webstorm.sh &"
alias xiv="flatpak run dev.goats.xivlauncher"
#SSH
alias ConnectToDarkSide="ssh root@142.93.186.27"

#displayConnection
alias hdmiExtend="xrandr --output HDMI-1-0 --mode 1920x1080 --right-of eDP-1"

#XInput stuff
alias tapToTouchEnable="xinput set-prop 15 346 1"
alias tapToDouchDisable="xinput set-prop 15 346 0"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
