{config, ...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identityFile = "${config.sops.secrets."sshkey/private".path}";
      };
      "github.com" = {
        forwardAgent = true;
      };
      "q.dev.ionata.com" = {
        forwardAgent = true;
      };
    };
  };
}
