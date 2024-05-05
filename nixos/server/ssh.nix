{config, ...}: {
  services.openssh = {
    enable = true;
  };
  users.users.${config.username}.openssh.authorizedKeys.keys = [""];
}
