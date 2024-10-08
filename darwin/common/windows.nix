{ pkgs, ... }:
{
  # enable non-Apple-signed arm64e binaries
  system.nvram.variables = {
    "boot-args" = "-arm64e_preview_abi";
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_opacity = "off";
      window_opacity_duration = "0.0";
      window_shadow = "off";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      split_type = "auto";
      auto_balance = "on";
      mouse_modifier = "ctrl";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
    extraConfig =
      let
        wallpaperScript = pkgs.writeShellApplication {
          name = "wallpaperScript";

          runtimeInputs = [
            pkgs.jq
            (import ../lib/wallpaper-bin.nix { inherit pkgs; })
          ];

          text = ''
            set -euox pipefail
            COLORS_PATH="$HOME/.config/wallpaper/colors.json"
            test -f "$COLORS_PATH"

            ${builtins.concatStringsSep "\n" (
              builtins.genList (x: ''
                COLOR=$(jq -r '.[${builtins.toString x}]' < "$COLORS_PATH")
                yabai -m space --focus ${builtins.toString (x + 1)} || true
                wallpaper set-solid-color "$COLOR" --screen 0
              '') 9
            )}
          '';
        };
      in
      ''
        sudo yabai --load-sa

        yabai -m config debug_output on
        yabai -m rule --add app="^Harvest$" manage=off

        for idx in $(yabai -m query --spaces | ${pkgs.lib.getExe pkgs.jq} '.[].index | select(. > 0)' | sort -nr); do
          yabai -m space --destroy "$idx"
        done

        ${
          (builtins.concatStringsSep "\n" (
            builtins.genList (x: ''
              yabai -m space --create
            '') 8
          ))
        }

        ${wallpaperScript}/bin/wallpaperScript
      '';
  };

  launchd.user.agents.yabai = {
    serviceConfig.StandardErrorPath = "/tmp/yabai_error";
    serviceConfig.StandardOutPath = "/tmp/yabai_out";
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - return [
        * : alacritty
        "alacritty" ~
      ]

      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east
      alt - k : yabai -m window --focus north
      alt - j : yabai -m window --focus south

      cmd + alt - h : yabai -m window --warp west
      cmd + alt - l : yabai -m window --warp east
      cmd + alt - k : yabai -m window --warp north
      cmd + alt - j : yabai -m window --warp south

      ${builtins.concatStringsSep "\n" (
        builtins.genList (
          x: "alt - ${builtins.toString (x + 1)} : yabai -m space --focus ${builtins.toString (x + 1)}"
        ) 9
      )}

      ${builtins.concatStringsSep "\n" (
        builtins.genList (
          x:
          "shift + alt - ${builtins.toString (x + 1)} : yabai -m window --space ${builtins.toString (x + 1)}"
        ) 9
      )}

      # resize mode
      :: resize @ : yabai -m config active_window_opacity 1; yabai -m config normal_window_opacity 0.9;
      alt - r ; resize
      resize < escape ; default
      resize < alt -r ; default
      resize < backspace : yabai -m space --balance
      resize < h : yabai -m window --resize right:-20:0 2> /dev/null || yabai -m window --resize left:-20:0 2> /dev/null
      resize < l : yabai -m window --resize right:20:0 2> /dev/null || yabai -m window --resize left:20:0 2> /dev/null
      resize < k : yabai -m window --resize bottom:0:-20 2> /dev/null || yabai -m window --resize top:0:-20 2> /dev/null
      resize < j : yabai -m window --resize bottom:0:20 2> /dev/null || yabai -m window --resize top:0:20 2> /dev/null
    '';
  };

  launchd.user.agents.skhd.serviceConfig.StandardErrorPath = "/tmp/skhd_error";
  launchd.user.agents.skhd.serviceConfig.StandardOutPath = "/tmp/skhd_out";
}
