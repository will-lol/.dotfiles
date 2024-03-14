{ config, ... }: {
  wayland.windowManager.hyprland = {
    settings.exec-once = [ "waybar" ];
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["cpu" "memory"];
        clock = {
          format = "{:%H:%M}";
          tooltip = true;
          tooltip-format = "{:%d/%m/%Y}";
        };
      };
    };
    style = ''
    * {
     font-family: monospace;
     color: #${config.colorScheme.palette.base05};
     background-color: #${config.colorScheme.palette.base01}
    }

    #workspaces button {
     border: none;
    }

    #workspaces button:hover {
     box-shadow: none;
     background: transparent;
     border: none;
    }

    #workspaces button.active {
     color: #F00;
    }

    #cpu, #memory {
     padding: 0 0.5rem;
    }
    '';
  };
}
