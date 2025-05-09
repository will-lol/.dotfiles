{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.brewCasks.ghostty;
    clearDefaultKeybinds = true;
    settings = {
      theme = "default";
      font-family = "FiraCode Nerd Font";
      keybind = [
        "super+enter=new_window"
        "super+page_up=scroll_page_up"
        "super+ctrl+equal=equalize_splits"
        "super+physical:four=goto_tab:4"
        "super+shift+down=jump_to_prompt:1"
        "super+shift+w=close_window"
        "super+shift+left_bracket=previous_tab"
        "super+backspace=esc:"
        "super+alt+i=inspector:toggle"
        "super+w=close_surface"
        "super+physical:eight=goto_tab:8"
        "super+alt+right=goto_split:right"
        "shift+up=adjust_selection:up"
        "super+down=jump_to_prompt:1"
        "super+t=new_tab"
        "super+c=copy_to_clipboard"
        "super+shift+right_bracket=next_tab"
        "super+physical:one=goto_tab:1"
        "shift+left=adjust_selection:left"
        "super+equal=increase_font_size:1"
        "shift+page_up=adjust_selection:page_up"
        "super+physical:three=goto_tab:3"
        "super+right=text:\\x05"
        "super+d=new_split:right"
        "super+ctrl+down=resize_split:down,10"
        "shift+end=adjust_selection:end"
        "super+plus=increase_font_size:1"
        "super+q=quit"
        "super+home=scroll_to_top"
        "super+ctrl+left=resize_split:left,10"
        "alt+left=esc:b"
        "super+ctrl+up=resize_split:up,10"
        "super+left=text:\\x01"
        "super+shift+up=jump_to_prompt:-1"
        "shift+right=adjust_selection:right"
        "super+comma=open_config"
        "super+shift+comma=reload_config"
        "super+minus=decrease_font_size:1"
        "shift+page_down=adjust_selection:page_down"
        "super+a=select_all"
        "alt+right=esc:f"
        "super+shift+enter=toggle_split_zoom"
        "super+alt+down=goto_split:bottom"
        "super+ctrl+f=toggle_fullscreen"
        "super+ctrl+right=resize_split:right,10"
        "super+alt+shift+j=write_scrollback_file:open"
        "shift+down=adjust_selection:down"
        "ctrl+shift+tab=previous_tab"
        "super+n=new_window"
        "super+alt+left=goto_split:left"
        "super+page_down=scroll_page_down"
        "super+alt+shift+w=close_all_windows"
        "super+alt+up=goto_split:top"
        "super+left_bracket=goto_split:previous"
        "super+physical:nine=last_tab"
        "super+right_bracket=goto_split:next"
        "super+end=scroll_to_bottom"
        "super+shift+j=write_scrollback_file:paste"
        "super+shift+d=new_split:down"
        "super+zero=reset_font_size"
        "super+physical:five=goto_tab:5"
        "shift+home=adjust_selection:home"
        "super+physical:seven=goto_tab:7"
        "super+up=jump_to_prompt:-1"
        "super+k=clear_screen"
        "super+physical:two=goto_tab:2"
        "super+physical:six=goto_tab:6"
        "super+v=paste_from_clipboard"
      ];
    };
    themes = {
      default = {
        palette = [
          "0=#${config.colorScheme.palette.base00}"
          "1=#${config.colorScheme.palette.base08}"
          "2=#${config.colorScheme.palette.base0B}"
          "3=#${config.colorScheme.palette.base0A}"
          "4=#${config.colorScheme.palette.base0D}"
          "5=#${config.colorScheme.palette.base0E}"
          "6=#${config.colorScheme.palette.base0C}"
          "7=#${config.colorScheme.palette.base05}"
          "8=#${config.colorScheme.palette.base03}"
          "9=#${config.colorScheme.palette.base08}"
          "10=#${config.colorScheme.palette.base0B}"
          "11=#${config.colorScheme.palette.base0A}"
          "12=#${config.colorScheme.palette.base0D}"
          "13=#${config.colorScheme.palette.base0E}"
          "14=#${config.colorScheme.palette.base0C}"
          "15=#${config.colorScheme.palette.base07}"
        ];

        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
        cursor-color = "#${config.colorScheme.palette.base05}";
        selection-background = "#${config.colorScheme.palette.base02}";
        selection-foreground = "#${config.colorScheme.palette.base05}";
      };
    };

    enableZshIntegration = true;
  };
}
