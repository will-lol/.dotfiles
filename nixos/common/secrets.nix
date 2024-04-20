{pkgs, config, ...}: {
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${config.username}/.config/sops/age/keys.txt";
  sops.secrets.samba = {};
  sops.secrets.tailscale = {};
  sops.secrets.github = {};
  environment.systemPackages = with pkgs; [cifs-utils];
}
