# My ricing DotFiles
# Overview
## Description
Back up of work and personal configuration files with a simple bash script to back up or restore files

## Dependencies
### Personal
- [i3wm](https://i3wm.org/docs/)
- [i3status-rust](https://github.com/greshake/i3status-rust)
- [rofi](https://github.com/davatorium/rofi)
- [nitrogen](https://github.com/l3ib/nitrogen)
- [picom](https://github.com/yshui/picom)

### Work
- [powerline](https://github.com/powerline/powerline)

### Shared
- [neovim](https://neovim.io/)
- [kitty](https://github.com/kovidgoyal/kitty)
- [tmux](https://github.com/tmux/tmux/wiki)
- [alacritty](https://alacritty.org/)

# Setup and runtime
## Shell commands
### If scripts are not executable
```shell
    chmod +x backupManager.sh
    chmod +x backupPersonal.sh
    chmod +x backupWork.sh
    chmod +x backupShared.sh
```
### running backupManager.sh script
```shell
# example command
backupManager.sh -a {backup/restore} -s {office/personal} -c {true/false}

# Back up work folders:
backupManager.sh -a backup -s office -c true;

# Restore work configs
backupManager.sh -a restore -s office -c true;
```
## CLI Flags
| Flag | Description |
|------|-------------|
| `-i` | interactive mode or not |
| `-a` | action to perform (on or off) |
| `-s` | setup to work on (office or personal) |
| `-c` | clean existing files or folders) |
| `-o` | backup source list |
| `-r` | a[r]chive |

