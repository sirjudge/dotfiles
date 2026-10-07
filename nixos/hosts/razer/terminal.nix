{ config, pkgs, lib, ... }:
{
    programs.zsh = {
	       enable = true;
        ohMyZsh = {
            enable = true;
            plugins = [ 
            "git" "aws" "battery" "dotenv" "emoji" "kubectl" "rust"
            ];
            theme = "fletcherm";
        };
    };
	environment.shells = with pkgs; [ zsh];
	users.defaultUserShell = pkgs.zsh;
}

