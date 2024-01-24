{ pkgs, ... }: {
  home.packages = with pkgs; [
    git-credential-oauth
  ];

  programs.git = {
    enable = true;
    userEmail = "will.bradshaw50@gmail.com";
    userName = "will";
    extraConfig = {
      credential.helper = [ "cache --timeout 7200" "${pkgs.git-credential-oauth}/bin/git-credential-oauth" ];
    };
  };
}
