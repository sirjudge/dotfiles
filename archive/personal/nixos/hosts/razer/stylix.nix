{ pgks, inputs,... }: 
{
   stylix = {
     polarity = "dark";
     # Here I set it so grub and gdm follow that theme too.
     enable = false;
     #base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
     #FIXME: this propery is mandatory in the current version
     # but in future version I will only set this on the home configuration.
     # image = ../../assets/Shogoki.png;

     cursor = {
       package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
       name = "rose-pine-cursor";
       size = 24;
    };
  };
}
