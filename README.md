# Dotfiles
## Overview
Back up of work and personal configuration files with a simple bash script to back up or restore files
### Work:
Windows 11 Powershell based CLI environment built to run .net core and azure related tasks. Contains a Microsoft powershell profile script in addition to using wezterm terminal.
### Peronsal:
NixOs ZSH based CLI environment built to run .NET and Rust with the use of repo based shell.nix and flake.nix files

## Dependencies
### Personal
- [NixOs](https://github.com/NixOS/nixpkgs)
- [Ghostty Terminal](https://github.com/ghostty-org/ghostty) 
### Work
- [Wezterm](https://github.com/wezterm/wezterm)
- [Powershell](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.5)

### Shared
- [neovim](https://github.com/neovim/neovim)
- [OpenCode](https://github.com/anomalyco/opencode/)
- [lazyGit](https://github.com/jesseduffield/lazygit)

## Setup and runtime Shell commands
Make script executable
```shell
    chmod +x backup.sh
```
Run back up or install
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
| `-w` | work Configuration |
| `-p` | personal  configuration|
