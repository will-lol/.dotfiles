{ pkgs, ... }: {
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/will/.config/sops/age/keys.txt";
  sops.secrets.samba = {};
  environment.systemPackages = with pkgs; [ cifs-utils ]; 
} 
