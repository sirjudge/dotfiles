# My ricing DotFiles
## Overview
### Description
Back up of work and personal configuration files with a simple bash script to back up or restore files




### Personal
- [i3wm](https://i3wm.org/docs/)
- [rofi](https://github.com/davatorium/rofi)
- [nitrogen](https://github.com/l3ib/nitrogen)

### Work
- []()

### Shared
- [neovim](https://neovim.io/)
- [kitty](https://github.com/kovidgoyal/kitty)
- [tmux](https://github.com/tmux/tmux/wiki)

## Setup
- if script is not executable
- Run backupManager.sh script
```bash
# Back up work folders:
backupManager.sh -a backup -s office -c true;

# Restore work configs
backupManager.sh -a restore -s office -c true;
```
