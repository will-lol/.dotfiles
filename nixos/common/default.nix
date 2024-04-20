{pkgs, ...}: {
  imports = [
    ./bootloader.nix
    ./hardware.nix
    ./packages.nix
    ./security.nix
    ./tailscale.nix
    ./nix.nix
    ./secrets.nix
    ./sound.nix
    ./virtualisation.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Hobart";
}
