{ pkgs, ... }: {
  imports = [
    ../../secrets.nix
    ./bootloader.nix
    ./hardware.nix
    ./packages.nix
    ./security.nix
    ./tailscale.nix
    ./nix.nix
    ./sound.nix
    ./virtualisation.nix
    ./users.nix
  ];

  i18n.defaultLocale = "en_AU.UTF-8";
  time.timeZone = "Australia/Hobart";
}
