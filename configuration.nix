# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.timeout = null;

  boot.loader.grub.splashImage = "/etc/nixos/nixos_splash.jpg";
  
  # security.doas.enable = true;
  
  boot.loader.grub.theme = "/etc/nixos/grub/bsol-main/bsol";

  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["quiet" "splash" ];
 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend ="iwd";
  #networking.networkmanager.wifi.backend = "wpa_supplicant";
  #programs.nm-applet.enable = true;
  
  #stable# services.logind.extraConfig = "HandlePowerKey=ignore"; #stable#
  services.logind.settings.Login = { HandlePowerKey = "ignore"; }; #unstable#
 
  hardware.bluetooth.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
    #xcursor = {
    #  theme = "Bibata-Modern-Ice";
    #  size = 24;
    #};
  };
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.enes = {
    isNormalUser = true;
    description = "enes";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "tray" "kvm" ];
    packages = with pkgs; [];
  };

  services = {
    asusd = { 
      enable = true;
      enableUserService = true;
    };
  };
  
  services.supergfxd.enable = true;
  services.flatpak.enable = true;
  programs.fish.enable = true;

  # Enable automatic login for the user.
  #autologin#services.getty.autologinUser = "enes";
  services.displayManager.ly.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;

  programs.localsend.enable = true; 
  programs.steam.enable = true;
  programs.thunar.enable = true; 
  services.gvfs.enable = true;  
  xdg.portal.xdgOpenUsePortal = true;


  programs.git.enable = true;
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
 
  xdg.icons.fallbackCursorThemes = [ "Bibata-Modern-Ice" ];
   
  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code-symbols
      nerd-fonts.fira-code
      
    ];
  };
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    clang-tools
    rust-analyzer    
 ];  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     rustup
     libgcc
     gcc
     nodejs_24
     gnumake
     tree
     cmake
     openjdk
     android-studio
     #
     android-tools
     #
     unixtools.ifconfig
     gocryptfs
     wget
     psmisc
     bluez
     bibata-cursors
     # nerd-fonts.fira-code
     kitty
     zed-editor
     mdcat
     vscodium
     lf
     nnn
     alacritty
     mpv
     gocryptfs
     ## xarchiver
     #
     # ags
     # hyprpanel
     # 
     waybar
     #rofi-wayland
     rofi
     xsensors
     btop
     cliphist
     wl-clipboard
     brightnessctl
     wlogout
     pavucontrol
     grim
     swappy
     mako
     libnotify
     bluetuith
     grimblast
     playerctl
     #
     #brave
     #
     nwg-drawer
     #
     fastfetch
     bibata-cursors
     #
     hyprpaper
     hyprshade
     #
     file
     exiftool
     bat
     chafa
     ffmpegthumbnailer
     jq
     lynx
     poppler_utils
     odt2txt
     catdoc
     atool
     nsxiv
     vlc
     xdg-utils
     zathura
     fzf
     archivemount
     unzip
     zip
     rar
     unrar
     xarchiver
  ];

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
