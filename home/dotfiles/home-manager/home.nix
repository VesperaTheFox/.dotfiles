{ config, pkgs, ... }:

let
  Graphite = pkgs.graphite-gtk-theme.override {
    themeVariants = [ "all" ];
    colorVariants = [ "dark" ];
    sizeVariants = [ "standard" ];
    tweaks = [ "rimless" "nord" ];
  };

in

{
  home.username = "vespera";
  home.homeDirectory = "/home/vespera";
  home.stateVersion = "26.05";

  # Force the build outputs into ~/.nix-profile/share/themes/
  home.packages = [
    Graphite
    pkgs.vimix-icon-theme
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Graphite-pink-Dark-nord";
      icon-theme = "Vimix-white";
    };
  };
  
  gtk = {
    enable = true;
    theme.package = Graphite;
    theme.name = "Graphite-pink-Dark-nord";

    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix-white";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/run/current-system/sw/share";
  };
}
