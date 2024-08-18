{pkgs, ...}: {
  programs.bash.enable = false;
  environment.systemPackages = [
    pkgs.nixVersions.latest
  ];
}
