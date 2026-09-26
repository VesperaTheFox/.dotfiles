{ config, lib, inputs, pkgs, ... }: 

let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles/home/dotfiles";

  entries = builtins.readDir ./dotfiles;

  included = [
    "hypr"
    "kitty"
    "librewolf"
    "nemo"
    "neofetch"
    "nvim"
    "obsidian"
    "obs-studio"
    "quickshell"
    "rofi"
    "vesktop"
    "waybar"
    "hyfetch.json"
    "starship.toml"
  ];

  mkLink = name: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${name}";

  configFiles = lib.mapAttrs'
    (name: _type: lib.nameValuePair name { source = mkLink name; })
    (lib.filterAttrs (name: _: builtins.elem name included) entries);
in
{

  home.username = "vespera";
  home.homeDirectory = "/home/vespera";
  home.stateVersion = "26.05";

  gtk = {
    enable = true;

  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.git = {
    enable = true;
    userName = "VesperaTheFox";
    userEmail = "michaelplblum@gmail.com";
  };

  xdg.configFile = configFiles;


  home.activation.dotfilesSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.openssh}/bin:$PATH"
    cd ${config.home.homeDirectory}/.dotfiles
    $DRY_RUN_CMD ${pkgs.git}/bin/git pull --rebase --autostash origin main || true
    $DRY_RUN_CMD ${pkgs.git}/bin/git add -A
    if ! ${pkgs.git}/bin/git diff --cached --quiet; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git commit -m "auto-sync on switch: $(date -Iseconds)"
      $DRY_RUN_CMD ${pkgs.git}/bin/git push origin main
    fi
  '';

  systemd.user.services.dotfiles-sync = {
    Unit.Description = "Auto-commit and push dotfiles";
    Service = {
      Type = "oneshot";
      WorkingDirectory = "${config.home.homeDirectory}/.dotfiles";
      ExecStart = pkgs.writeShellScript "dotfiles-sync" ''
        export PATH="${pkgs.openssh}/bin:$PATH"
        set -e
        cd ${config.home.homeDirectory}/.dotfiles
        ${pkgs.git}/bin/git pull --rebase --autostash origin main || true
        ${pkgs.git}/bin/git add -A
        if ! ${pkgs.git}/bin/git diff --cached --quiet; then
          ${pkgs.git}/bin/git commit -m "auto-sync: $(date -Iseconds)"
          ${pkgs.git}/bin/git push origin main
        fi
      '';
    };
  };

  systemd.user.timers.dotfiles-sync = {
    Unit.Description = "Timer for dotfiles auto-sync";
    Timer = {
      OnCalendar = "*:0/30";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}

