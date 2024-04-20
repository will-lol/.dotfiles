{
  users = {
    users = {
      ${config.username} = {
        isNormalUser = true;
        extraGroups = ["wheel" "sudo"];
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
