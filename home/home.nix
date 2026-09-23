{ inputs, pkgs, ... }: {

  home.username = "vespera";
  home.homeDirectory = "/home/vespera";
  home.stateVersion = "26.05";

  # Enable and configure GTK using Catppuccin
  gtk = {
    enable = true;
    # Let Catppuccin handle the theme styling automatically
  };
  
  # Optional: If you want standard GTK dark mode enforcement
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Symlinks for apps without native nix modules (Step 6 approach)
  xdg.configFile."hypr".source = ./dotfiles/hypr;
  xdg.configFile."kitty".source = ./dotfiles/kitty;
  xdg.configFile."nvim".source = ./dotfiles/nvim;
  xdg.configFile."rofi".source = ./dotfiles/rofi;
  xdg.configFile."waybar".source = ./dotfiles/waybar;
}

