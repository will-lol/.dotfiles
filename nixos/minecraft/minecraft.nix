{ pkgs, lib, ... }: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.smp = {
      enable = true;
      autoStart = true;
      restart = "always";
      whitelist = {
        MrMoose65 = "d59a8191-581a-4c66-8e3b-b3c66e76bb3c";
      };
      serverProperties = {
        server-port = 25565;
        difficulty = 2;
        gamemode = 0;
        max-players = 5;
        motd = "NixOS Minecraft Server!";
        white-list = true;
      };
      symlinks = {
        plugins = pkgs.linkFarmFromDrvs "plugins" (builtins.attrValues {
          Harbor = pkgs.fetchurl { url = "https://github.com/nkomarn/harbor/releases/download/1.6.3/Harbor-1.6.3.jar"; sha256 = "sha256-JvvuwGKHojGz7AyqFZXrzVPU8RBpk98SmFprLO39IrA="; };
        });
      };
      package = pkgs.minecraftServers.paper-1_17_1;
    };
  };
}
