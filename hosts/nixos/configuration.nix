# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  users.users.vespera.isNormalUser = true;
  users.users.vespera.description = "vespera";
  users.users.vespera.extraGroups = [ "networkmanager" "wheel" ];
  
  # Home Manager via Flakes module

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # enable tailscale
  services.tailscale.enable = true;

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
 
  # enable ohmyzsh
  programs.zsh.ohMyZsh.enable = true;

  #flatpacs -_-
  services.flatpak.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "vespera";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
    };
  };

  systemd.services.accounts-daemon.serviceConfig.TimeoutStartSec = "5s";
  systemd.services.accounts-daemon.serviceConfig.TimeoutStopSec = "5s";

  #Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # XDG
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland 
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common = {
      default = [ "hyprland" "gtk" ];
    };
  };

  # Enable Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # powers up the default controller on boot
    settings = {
      General = {
        Experimental = true; # enables extra features like battery charge reporting
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.uwsm.enable = true; 

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  #    If you want to use JACK applications, uncomment this
    jack.enable = true;

  #   use the example session manager (no others are packaged yet so this is enabled by default,
  #   no need to redefine it in your config for now)
  #   media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Disable firefox for Librewolf
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # steam config
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    package = inputs.millennium.packages.${pkgs.system}.default;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     steam
     kitty
     prismlauncher
     ffmpeg
     hyprland
     librewolf
     starship
     krita
     tree
     nemo
     awww
     obs-studio
     unzip
     bluez
     neovim
     vesktop
     wine
     dbus
     gimp
     steam-run
     kicad
     git
     obsidian
     quickshell
     javaPackages.compiler.temurin-bin.jdk-25
     davinci-resolve
     pavucontrol
     qpwgraph
     (discord.override {
       withVencord = true;
     })
     waybar
     zsh
     discord
     hyfetch
     rofi
     swaynotificationcenter
     xdg-desktop-portal-hyprland
     polkit_gnome
     nwg-look
     gsettings-desktop-schemas
     udiskie
     # home-manager package removed from systemPackages since it's now managed via module inputs
     glib
     pywal16
     matugen
     playerctl
     rustup
     hypridle
     (python3.withPackages (ps: with ps; [
       pygobject3
       dbus-python
     ]))
     gobject-introspection
     hyprlock

     (pkgs.stdenvNoCC.mkDerivation {
       pname = "layan-cursors";
       version = "unstable-2021-08-01";

       src = pkgs.fetchFromGitHub {
         owner = "vinceliuice";
         repo = "Layan-cursors";
         rev = "master";
         sha256 = "sha256-OfokAg0emLLG4IiExsjTS3kPfy0BVPBCLjzKHGdrjg4="; # Replace with hash on first build
       };

       installPhase = ''
         runHook preInstall
         mkdir -p $out/share/icons/Layan-cursors
         cp -r dist/* $out/share/icons/Layan-cursors/
         runHook postInstall
       '';
     })
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Iosevka Nerd Font Mono" ];
        sansSerif = [ "Iosevka Nerd Font Mono" ];
        monospace = [ "Iosevka Nerd Font Mono" ];
      };
    };
  };

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "$XDG_DATA_DIRS"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    ];
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

# In your configuration.nix
  nixpkgs.config.packageOverrides = pkgs: {
    davinci-resolve = pkgs.davinci-resolve.overrideAttrs (old: {
    # If you need to patch the wrapper or wrap program:
      postFixup = (old.postFixup or "") + ''
        # Ensure it forces xcb and has the proper OpenCL vendors exposed
        wrapProgram $out/bin/davinci-resolve \
          --set QT_QPA_PLATFORM xcb \
          --set OCL_ICD_VENDORS /run/opengl-driver/etc/OpenCL/vendors/ \
          --set ROC_ENABLE_PRE_VEGA 1
      '';
    });
  };

  environment.extraInit = ''
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  '';

  programs.dconf.enable = true;

  services.dbus.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment? yes

}
