{ config, pkgs, lib,... }:
{  
  programs.tmux = {
      enable = true;
      plugins = (with pkgs.tmuxPlugins; [
           vim-tmux-navigator
           vim-tmux-focus-events
           yank
           rose-pine
      ]);
	  extraConfig = ''
        set -g default-command ${pkgs.zsh}/bin/zsh
        set-option -sg escape-time 10
        # fix colors in terminal
        # this is the command 		    
        #set -as terminal-overrides ",screen*:Tc"
        set-option -g default-terminal "screen-256color"
        #set -ag terminal-overrides ",xterm-kitty:Tc"
        #set -g default-terminal "tmux-256color"

        # enable mouse support
        set -g mouse on

        # set windows to start at 1
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # use vim mode keys to move around and do stuff
        set -g mode-keys vi

        # set yank to copy to system clipboard
        bind-key -T copy-mode-vi v send-keys -X begin-selection 
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    
        # set default behavior to open tabs and splits in the same directory
        bind  c  new-window      -c "#{pane_current_path}"
        bind  %  split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"

        # set colorscheme back to rose pine
        set -g @rose_pine_variant 'moon'
        set -g @rose_pine_host 'on' # Enables hostname in the status bar
        set -g @rose_pine_directory 'on' # Turn on the current folder component in the status bar
        set -g @rose_pine_git 'on' # Turn on the git status component in the status bar
        set -g @rose_pine_left_separator '  ' # The strings to use as separators are 1-space padded
        set -g @rose_pine_right_separator '  ' # Accepts both normal chars & nerdfont icons
        set -g @rose_pine_field_separator '  ' # Again, 1-space padding, it updates with prefix + I
        set -g @rose_pine_bar_bg_disable 'on' # Disables background color, for transparent terminal emulators

		  '';
  };
}
