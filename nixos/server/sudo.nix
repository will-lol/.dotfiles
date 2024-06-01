{config, ...}: {
  security.sudo.extraRules = [
    {
      users = ["${config.username}"];
      options = ["NOPASSWD"];
    }
  ];
}
