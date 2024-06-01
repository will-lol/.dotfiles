{pkgs, config, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  nix = {
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than +10";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = ["${config.username}"];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      !include ${config.sops.secrets.github.path}
    '';
  };
}
