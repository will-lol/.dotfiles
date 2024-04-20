{config, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;
  users.users.${config.username}.extraGroups = ["libvirtd" "docker"];
}
