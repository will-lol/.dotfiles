{pkgs, ...}: {
  home.packages = [
    pkgs.amazon-ecr-credential-helper
  ];
  home.file = {
    ".docker/config.json".text = ''
      {
        "credsStore": "ecr-login"
      }
    '';
  };


}
