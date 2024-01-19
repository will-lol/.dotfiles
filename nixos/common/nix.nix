{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
