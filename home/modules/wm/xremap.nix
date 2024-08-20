{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [ ydotool ];

  systemd.user.services.xremap.Service.Environment = lib.mkForce [
    "PATH=/run/current-system/sw/bin:/home/${config.username}/.nix-profile/bin"
    "YDOTOOL_SOCKET=/home/${config.username}/.ydotool_socket"
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      ''
        sudo -b ${pkgs.ydotool}/bin/ydotoold --socket-path="$HOME/.ydotool_socket" --socket-own="$(id -u):$(id -g)"''
    ];
    env = [ "YDOTOOL_SOCKET,$HOME/.ydotool_socket" ];
  };

  services.xremap = {
    withWlroots = true;
    config = {
      keymap = [{
        name = "mixxx";
        remap = {
          "d" = {
            launch = [
              "bash"
              "-c"
              "ydotool mousemove -a -x 20 -y 195 && ydotool click C0 && ydotool mousemove -a -x 412 -y 65 && ydotool click C1 && ydotool mousemove -a -x 412 -y 85 && ydotool click C1 && ydotool mousemove -a -x 25 -y 130 && ydotool click C1 && ydotool mousemove -a -x 25 -y 145 && ydotool click C0"
            ];
          };
        };
        application = { "only" = "org.mixxx."; };
      }];
    };
  };
}
