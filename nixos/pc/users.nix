{config, pkgs, ...}: {
  users = {
    users = {
      ${config.username} = {
        isNormalUser = true;
        uid = 1000;
        group = "users";
        shell = pkgs.zsh;
      };
    };
    groups = {
      users = {
        gid = 100;
      };
    };
  };
}
