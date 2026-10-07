{pkgs,lib,...}:
{
  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    userName  = "Nico Judge";
    userEmail = "nico.a.judge@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
      color.ui = true;
      core = {
        editor = "nvim";
      };
      init.defaultBranch = "main"; 
    };
  };
}
