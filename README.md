# Dotfiles
## Overview
Back up of work and personal configuration files with a simple bash script to back up or restore files

## Dependencies
### Personal
- nixos

### Work
- [powerline](https://github.com/powerline/powerline)
- [kitty](https://github.com/kovidgoyal/kitty)
- [tmux](https://github.com/tmux/tmux/wiki)
- [alacritty](https://alacritty.org/)

### Shared
- [neovim](https://neovim.io/)


## Setup and runtime Shell commands
### If scripts are not executable
```shell
    chmod +x backup.sh
```
### running backupManager.sh script
```shell
# Back up work folders:
./backup.sh -b -w

# Restore work configs
./backup.sh -i -w
```
## CLI Flags
| Flag | Description |
|------|-------------|
| `-i` | Install files from dotfiles repo to system configurations |
| `-b` | backup action should occurr |
| `-w` | work computer |
| `-p` | personal computer  |
