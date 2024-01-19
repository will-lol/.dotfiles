{ pkgs, ... }: {
  home.packages = with pkgs; [
    git-credential-oauth
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = [ "cache --timeout 7200" "${pkgs.git-credential-oauth}/bin/git-credential-oauth" ];
    };
  };
}
