# Path to your oh-my-zsh installation.
  export ZSH=/home/nico/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
#export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux sublime)

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# changes the colors and stuff
# (wal -r &)


alias plswork='sudo vmware-modconfig --console --install-all'

alias pacupg='sudo pacman -Syu'   # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman -S'      # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'     # Install specific package not from the repositories but from a file
alias pacre='sudo pacman -R'      # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'   # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'         # Display information about a given package in the repositories
alias pacreps='pacman -Ss'        # Search for package(s) in the repositories
alias pacloc='pacman -Qi'         # Display information about a given package in the local database
alias paclocs='pacman -Qs'        # Search for package(s) in the local database

alias yaupg='yaourt -Syua'    # Synchronize with repositories before upgrading packages (AUR packages too) that are out of date on the local system.
alias yasu='yaourt --sucre' # Same as yaupg, but without confirmation
alias yain='yaourt -S'      # Install specific package(s) from the repositories
alias yains='yaourt -U'     # Install specific package not from the repositories but from a file
alias yare='yaourt -R'      # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias yarem='yaourt -Rns'   # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias yarep='yaourt -Si'    # Display information about a given package in the repositories
alias yasearch='yaourt -Ss'   # Search for package(s) in the repositories
alias yaloc='yaourt -Qi'    # Display information about a given package in the local database
alias yalocs='yaourt -Qs'   # Search for package(s) in the local database
alias yalst='yaourt -Qe'    # List installed packages, even those installed from AUR (they're tagged as "local")
alias yaorph='yaourt -Qtd'  # Remove orphans using yaourt

alias multiMonitor='xrandr --output HDMI2 --auto --left-of LVDS1;'
alias displayPort='xrandr --output DP1 --auto --left-of LVDS1;'

alias fuckoff='sudo vmware-modconfig --console --install-all'

alias phoenix='ssh -X -C njudge@phoenix.goucher.edu'
alias stable='ssh -X -C stable42@phoenix.goucher.edu'
alias UseTheForce='ssh nico@138.197.100.100'

alias mountTheForce='sshfs nico@138.197.100.100:/home/ /home/nico/Documents/website'

#mount and unmount phoenix to /home/documents/comp sci/phoenix directory
alias mountPhoenix='sshfs njudge@phoenix.goucher.edu:/home/njudge/ ~/Documents/CompSci/phoenix'
alias unmountPhoenix='sudo umount /home/nico/Documents/CompSci/phoenix'

#alias mountShakey='sshfs njudge@phoenix.goucher.edu:/home/njudge/Documents/shakey ~/Documents/CompSci/phoenix/shakey'
alias mountShakey='sshfs shakey:/home ~/Documents/CompSci/shakey'
alias unmountShakey='fusermount -u ~/Documents/CompSci/shakey'

alias mountStable='sshfs stable42@phoenix.goucher.edu:/home/stable42/ ~/Documents/CompSci/stable42'
alias unmountStable='sudo umount /home/nico/Documents/CompSci/stable42 '

alias runBot='python test.py; rm /tmp/bot-log*; java -jar match-wrapper-1.3.2.jar "$(cat wrapper-commands.json)"'

