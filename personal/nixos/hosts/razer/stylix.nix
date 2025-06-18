{ pgks, inputs,... }:
{

 gtk = {
    enable = true;
    font = fonts.sansSerif;
    iconTheme = icons;
    cursorTheme = cursor;
    theme = = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "breeze";
  };


  stylix = {
    polarity = "dark";
    enable = true;

    autoEnable = true;
    targets.pavucont

    cursor = {
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      name = "rose-pine-cursor";
      size = 24;
    };

    cursorfonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      noto-fonts-emoji
        dejavu_fonts
    ];

    stylix = {
      enable = true;

      # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

        base16Scheme = {
      slug = "oxocarbon-dark";
      name = "Oxocarbon Dark";
      author = "shaunsingh/IBM";
      palette = {
        base00 = "161616";
        base01 = "262626";
        base02 = "393939";
        base03 = "525252";
        base04 = "dde1e6";
        base05 = "f2f4f8";
        base06 = "ffffff";
        base07 = "08bdba";
        base08 = "3ddbd9";
        base09 = "78a9ff";
        base0A = "ee5396";
        base0B = "33b1ff";
        base0C = "ff7eb6";
        base0D = "42be65";
        base0E = "be95ff";
        base0F = "82cfff";
      };
    };
    
      polarity = "dark";

    fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          name = "JetBrainsMono Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = 10;
          terminal = 10;
          desktop = 10;
          popups = 10;
        };
      };

      targets.nixvim.enable = false;
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      name = "rose-pine-cursor";
      size = 24;
    };
  };
}
