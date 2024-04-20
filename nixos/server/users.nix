{config, ...}: {
  users = {
    users = {
      ${config.username} = {
        isNormalUser = true;
        uid = 1000;
        group = "users";
      };
    };
    groups = {
      users = {
        gid = 100;
      };
    };
  };
}
