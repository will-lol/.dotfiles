{pkgs, ...}: {
  programs.bash.enable = false;
  environment.systemPackages = [
    pkgs.brewCasks.slack
  ];
}
