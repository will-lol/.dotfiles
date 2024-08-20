{ pkgs, ... }: {
  programs.waybar = {
    settings = { mainBar = { modules-right = [ "battery" ]; }; };
  };

  home.packages = with pkgs; [ batsignal ];
  systemd.user.services.batsignal = {
    Unit = { Description = "Battery monitor daemon"; };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.batsignal}/bin/batsignal -c 10 -C "Critical battery level. Laptop may shutdown unexpectedly unless plugged in." -d 5 -D "shutdown now" -p -P "Plugged in, charging" -U "Unplugged, discharging"'';
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
