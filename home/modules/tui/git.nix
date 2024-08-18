{pkgs, ...}: {
  home.packages = with pkgs; [
    pass
  ];

  programs.git = {
    enable = true;
    userEmail = "will.bradshaw50@gmail.com";
    userName = "will";
    extraConfig = {
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      init.defaultBranch = "main";
    };
  };
}
