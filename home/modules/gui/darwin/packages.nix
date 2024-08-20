{ pkgs, ... }: {
  home.packages = with pkgs; [ brewCasks.firefox brewCasks.slack ];
}
