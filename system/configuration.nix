{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true; # Allow installation of unfree packages from nixpkgs
  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 10; # Limits the number of nixos generations listed in grub
  security.polkit.enable = true;

  # Random features
  virtualisation.docker.enable = true;
  services.flatpak.enable = true;

  # virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Enabling flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Networking stuff
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true; 
  time.timeZone = "Australia/Hobart";

  # Bluetooth
  services.blueman.enable = true;

  fonts.fontDir.enable = true; # Enabled for greater compatability

  # gnupg
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    libva-utils 
    git
    libsecret
    ifuse
    pinentry-curses
    wget
    libimobiledevice
    nvtop-nvidia
    cifs-utils
  ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl nvidia-vaapi-driver ];
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };

  hardware.sane.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  hardware.uinput.enable = true;
  users.users.will = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "scanner" "lp" "libvirtd" "uinput" "input" ]; 
  };

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/will/.config/sops/age/keys.txt";
  sops.secrets.samba = {};

  systemd.services."automountcredentials" = {
    partOf = [ "mnt-share.mount" ];
    wantedBy = [ "mnt-share.mount" ];
    before = [ "mnt-share.mount" ];
    script = ''
      echo "username=will
      password=$(cat ${config.sops.secrets."samba".path})" > /etc/nixos/smb-secrets
    '';
  };

  fileSystems."/mnt/share" = {
    device = "//192.168.1.26/will";
    fsType = "cifs";
    options = let 
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  security.sudo.extraRules = [
    {
      users = [ "will" ];
      commands = [
        {
          command = "${pkgs.ydotool}/bin/";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  programs.hyprland.enable = true;

  system.stateVersion = "23.05"; 
}

