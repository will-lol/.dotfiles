{ config, pkgs, lib, nix-colors, xremap-flake, localpkgs, ... }: {
  imports = [ nix-colors.homeManagerModules.default xremap-flake.homeManagerModules.default ./nvim.nix ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "will";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.


  colorScheme = nix-colors.colorSchemes.tokyo-night-storm;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
