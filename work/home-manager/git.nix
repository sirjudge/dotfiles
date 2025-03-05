{pkgs,lib,...}:
{
    programs.lazygit.enable = true;
    
    programs.git = {
        enable = true;
        userName  = "Nico Judge";
        userEmail = "nicholas.judge@shareasale.com";
        extraConfig = {
            push = { autoSetupRemote = true; };
        };
    };
}
