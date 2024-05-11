{pkgs, config, ...}: {
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${config.username}/.config/sops/age/keys.txt";
  sops.secrets.samba = {};
  sops.secrets.tailscale = {};
  sops.secrets.github = {};
  sops.secrets."bitwarden/client_id" = {}; 
  sops.secrets."bitwarden/client_secret" = {};
  sops.secrets."sshkey/private" = {};
  sops.secrets."sshkey/public" = {};
}
