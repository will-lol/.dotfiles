{ config, pkgs, lib, nix-colors, ... }: {
  imports = [nix-colors.homeManagerModules.default];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "will";
  home.homeDirectory = "/home/will";

  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
    gtk.enable = true;
    x11.enable = true;
  };

  colorScheme = nix-colors.colorSchemes.tokyo-night-storm;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    nerdfonts
    neovim
    htop-vim
    yt-dlp
    obs-studio
    hyprpicker
    ffmpeg
    audacity
    firefox
    mpv
    playerctl
    swayimg
    corefonts
    flatpak
    swaybg
    wob
    liberation_ttf
    clipman
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "libsecret";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = { 
	  background = "0x${config.colorScheme.colors.base00}";
	  foreground = "0x${config.colorScheme.colors.base05}";
	};  
	cursor = {
	  text = "0x${config.colorScheme.colors.base00}";
	  cursor = "0x${config.colorScheme.colors.base05}";
	};  
      };	  
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    nvidiaPatches = true;
    extraConfig = ''
      misc {
        disable_hyprland_logo = true
      }

      animations {
        enabled = no
      }

      bind = SUPER, Return, exec, alacritty

      monitor = DP-2,1920x1080@75,0x0,1
      
      env = WLR_NO_HARDWARE_CURSORS,1
      
      exec-once = waybar

      exec-once = swaybg -c "##${config.colorScheme.colors.base00}"
      general {
        col.active_border = rgb(${config.colorScheme.colors.base05})
	col.inactive_border = rgb(${config.colorScheme.colors.base04})
      }
      
      exec-once = playerctld daemon
      bind =, XF86AudioPlay, exec, playerctl play-pause
      bind =, XF86AudioPrev, exec, playerctl previous
      bind =, XF86AudioNext, exec, playerctl next

      env = WOBSOCK,$XDG_RUNTIME_DIR/wob.sock
      exec-once = rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob
      binde =,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK
      binde =,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK
      bind =,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK

      bind = SUPER, H, movefocus, l
      bind = SUPER, L, movefocus, r
      bind = SUPER, K, movefocus, u
      bind = SUPER, J, movefocus, d

      bind = SUPER SHIFT, Q, killactive
     
      bind = SUPER, H, movewindow, l
      bind = SUPER, L, movewindow, r
      bind = SUPER, K, movewindow, u
      bind = SUPER, J, movewindow, d

      bind = SUPER, R, submap, resize
      submap = resize
      binde =, L, resizeactive, 40 0
      binde =, H, resizeactive, -40 0
      binde =, K, resizeactive, 0 -40
      binde =, J, resizeactive, 0 40
      bind =, escape, submap, reset
      bind =, Return, submap, reset
      submap = reset

      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      bind = SUPER SHIFT, 1, movetoworkspacesilent, 1
      bind = SUPER SHIFT, 2, movetoworkspacesilent, 2
      bind = SUPER SHIFT, 3, movetoworkspacesilent, 3
      bind = SUPER SHIFT, 4, movetoworkspacesilent, 4
      bind = SUPER SHIFT, 5, movetoworkspacesilent, 5
      bind = SUPER SHIFT, 6, movetoworkspacesilent, 6
      bind = SUPER SHIFT, 7, movetoworkspacesilent, 7
      bind = SUPER SHIFT, 8, movetoworkspacesilent, 8
      bind = SUPER SHIFT, 9, movetoworkspacesilent, 9
      bind = SUPER SHIFT, 0, movetoworkspacesilent, 10

      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1

      bind = SUPER, D, exec, wofi --show run

      input {
        repeat_delay = 250
	repeat_rate = 35
      }
    '';
  };

  programs.wofi = {
    enable = true;
    style = ''
      * {
        font-family: monospace;
      }

      #window {
        background-color: #${config.colorScheme.colors.base00};
      }
 
      #entry:selected {
        background-color: #${config.colorScheme.colors.base02};
      }

      #text {
        color: #${config.colorScheme.colors.base0B};
	padding: 0.2rem 0.5rem;
      }

      #input {
        color: #${config.colorScheme.colors.base05};
	background-color: #${config.colorScheme.colors.base01};
	border: none;
	border-radius: 0;
      }
    '';
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
       modules-right = ["wirepumber" "cpu" "memory"];
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
       color: #${config.colorScheme.colors.base05};
       background-color: #${config.colorScheme.colors.base01}
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

  services.mako = {
    enable = true;
    borderColor = "#${config.colorScheme.colors.base04}";
    textColor = "#${config.colorScheme.colors.base05}";
    defaultTimeout = 3000;
    backgroundColor = "#${config.colorScheme.colors.base01}";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/wob/wob.ini".text = ''
      anchor = bottom
      margin = 100
      border_size = 2
      bar_padding = 0
      border_offset = 5
      background_color = ${config.colorScheme.colors.base01}
      border_color = ${config.colorScheme.colors.base04}
      bar_color = ${config.colorScheme.colors.base05}
      height = 30
    '';
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/will/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
