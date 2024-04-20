{
  users = {
    users = {
      ${config.username} = {
        isNormalUser = true;
        uid = 1000;
      };
    };
    groups = {
      users = {
        gid = 100;
      };
    };
  };
}
