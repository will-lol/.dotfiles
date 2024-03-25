{ pkgs, config, ... }: 
let user = "will"; in {
  nix = {
    package = pkgs.nixUnstable;
    settings.trusted-users = [ "@admin" "${user}" ]
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.checks.verifyNixPath = false;
  fonts.fontDir.enable = true;
}
