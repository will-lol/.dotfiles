{ config, pkgs, lib, nix-colors, localpkgs, ... }: {
  imports = [ nix-colors.homeManagerModules.default ./nvim.nix ];
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
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    mixxx
    grim
    slurp
    gimp
    
    hyprland
    ripgrep
    trashy
    aria2
    nodejs
    nerdfonts
    entr
    htop-vim
    tree-sitter
    calibre
    yt-dlp
    gcc
    cliphist
    obs-studio
    kalker
    wl-clipboard
    hyprpicker
    nodePackages.vscode-langservers-extracted
    ffmpeg
    audacity
    tofi
    # zotero
    mpv
    playerctl
    swayimg
    unzip
    pipes-rs
    corefonts
    flatpak
    swaybg
    wob
    liberation_ttf
    libre-franklin
    libre-baskerville
    inter
    garamond-libre
    lunar-client
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

  # Setup virtualisation in virt-manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;

  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
	"browser.toolbars.bookmarks.visibility" = "never";
	"browser.newtabpage.enabled" = false; 
	"browser.startup.homepage" = "about:blank";
      };
      extensions = with config.nur.repos.rycee.firefox-addons; [multi-account-containers firefox-translations vimium];
      search.engines = {
	"WordReference Conjugate" = {
	  urls = [{
	    template = "https://www.wordreference.com/conj/esverbs.aspx?v={searchTerms}";
	  }];
	  definedAliases = ["@conj"]; };
	"WordReference" = {
	  urls = [{
	    template = "https://www.wordreference.com/es/translation.asp?tranword={searchTerms}";
	  }];
	  definedAliases = ["@word"];
	};
	"Reddit - subreddit" = {
	  urls = [{
	    template = "https://www.reddit.com/r/{searchTerms}";
	  }];
	  definedAliases = ["r/"];
	};
	"Reddit" = {
	  urls = [{
	    template = "https://www.reddit.com/search/?q={searchTerms}";
	  }];
	  definedAliases = ["@reddit"];
	};
	"Github" = {
	  urls = [{
	    template = "https://github.com/search?q={searchTerms}";
	  }];
	  definedAliases = ["@github"];
	};
	"Dictionary" = {
	  urls = [{
	    template = "https://www.oed.com/search/dictionary/?q={searchTerms}";
	  }];
	  definedAliases = ["@dict"];
	};
	"es" = {
	  urls = [{
	    template = "https://translate.google.com/?sl=es&tl=en&text={searchTerms}&op=translate";
	  }];
	  definedAliases = ["@es"];
	};
	"en" = {
	  urls = [{
	    template = "https://translate.google.com/?sl=en&tl=es&text={searchTerms}&op=translate";
	  }];
	  definedAliases = ["@en"];
	};
      };
    };
  };

  programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
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
    extraConfig = ''
      misc {
        disable_hyprland_logo = true
      }

      animations {
        enabled = no
      }

      bind = SUPER, Return, exec, alacritty

      monitor = DP-1,1920x1080@75,0x0,1
      
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

      bind =, Print, exec, grim -g "$(slurp)" - | wl-copy -t image/png
      bind = SUPER, Print, exec, NAME=$(uuidgen).png;grim -g "$(slurp)" /tmp/$NAME.png; gimp /tmp/$NAME.png

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

      bind = SUPER, D, exec, tofi-run | xargs hyprctl dispatch exec -- 

      input {
        repeat_delay = 250
	repeat_rate = 35
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
      bar_padding = 2
      border_offset = 2
      background_color = ${config.colorScheme.colors.base01}
      border_color = ${config.colorScheme.colors.base06}
      bar_color = ${config.colorScheme.colors.base0E}
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

  home.file = {
    ".config/tofi/config".text = ''
       font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/FiraCodeNerdFont-Regular.ttf" 
       width = 100%
       height = 100%  
       border-width = 0
       outline-width = 0
       text-cursor = true
       padding-left = 35%
       padding-top = 35%
       result-spacing = 25
       num-results = 5
       background-color = #${config.colorScheme.colors.base00}99
       default-result-background = #${config.colorScheme.colors.base00}
       default-result-color = #${config.colorScheme.colors.base03}
       default-result-background-padding = 10
       selection-background = #${config.colorScheme.colors.base02}
       selection-background-padding = 10
       selection-color = #${config.colorScheme.colors.base0E}
       selection-match-color = #${config.colorScheme.colors.base0C}
       input-color = #${config.colorScheme.colors.base0C}
       prompt-text = "run " 
       prompt-color = #${config.colorScheme.colors.base05}
       result-spacing = 30
    ''; 
  };

  
  home.file = {
    ".config/fontconfig/fonts.conf".text = ''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
  <match target="pattern">
    <test name="family" qual="any">
      <string>monospace</string>
    </test>
    <edit binding="strong" mode="prepend" name="family">
      <string>FiraCode Nerd Font</string>
    </edit>
  </match> 
  <match target="pattern">
    <test name="family" qual="any">
      <string>sans-serif</string>
    </test>
    <edit binding="strong" mode="prepend" name="family">
      <string>Inter</string>
    </edit>
  </match>
  <match target="pattern">
    <test name="family" qual="any">
      <string>serif</string>
    </test>
    <edit binding="strong" mode="prepend" name="family">
      <string>Garamond Libre</string>
    </edit>
  </match>
</fontconfig>
    '';
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
    EDITOR = "nvim";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      calc = "kalker";
      view = "swayimg";
      download = "aria2c";
      copy = "wl-copy";
      paste = "wl-paste";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
