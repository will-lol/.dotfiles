{ pkgs, config, ... }: {
  programs.zsh.enable = true;
  users.users.${config.username}.shell = pkgs.zsh;
}
