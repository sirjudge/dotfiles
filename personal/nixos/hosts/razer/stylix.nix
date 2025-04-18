{ pgks, inputs,... }: 
{
	stylix = {
		polarity = "dark";

# Here I set it so grub and gdm follow that theme too.
		enable = true;

		cursorfonts.fontconfig.enable = true;
		home.packages = with pkgs; [
			noto-fonts-emoji
				dejavu_fonts
		];

		stylix = {
			enable = true;

			base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

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
# targets.rofi.enable = false; = {
	package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
	name = "rose-pine-cursor";
	size = 24;
};
};
}
