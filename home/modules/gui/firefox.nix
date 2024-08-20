{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then
      pkgs.brewCasks.firefox
    else
      pkgs.firefox;
    profiles.default = {
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "media.ffmpeg.vaapi.enabled" = true;
      };
      extensions = with config.nur.repos.rycee.firefox-addons; [
        multi-account-containers
        firefox-translations
        vimium
      ];
      search.engines = {
        "WordReference Conjugate" = {
          urls = [{
            template =
              "https://www.wordreference.com/conj/esverbs.aspx?v={searchTerms}";
          }];
          definedAliases = [ "@conj" ];
        };
        "WordReference" = {
          urls = [{
            template =
              "https://www.wordreference.com/es/translation.asp?tranword={searchTerms}";
          }];
          definedAliases = [ "@word" ];
        };
        "Reddit - subreddit" = {
          urls = [{ template = "https://www.reddit.com/r/{searchTerms}"; }];
          definedAliases = [ "r/" ];
        };
        "Reddit" = {
          urls =
            [{ template = "https://www.reddit.com/search/?q={searchTerms}"; }];
          definedAliases = [ "@reddit" ];
        };
        "Github" = {
          urls = [{ template = "https://github.com/search?q={searchTerms}"; }];
          definedAliases = [ "@github" ];
        };
        "Dictionary" = {
          urls = [{
            template = "https://www.oed.com/search/dictionary/?q={searchTerms}";
          }];
          definedAliases = [ "@dict" ];
        };
        "es" = {
          urls = [{
            template =
              "https://translate.google.com/?sl=es&tl=en&text={searchTerms}&op=translate";
          }];
          definedAliases = [ "@es" ];
        };
        "en" = {
          urls = [{
            template =
              "https://translate.google.com/?sl=en&tl=es&text={searchTerms}&op=translate";
          }];
          definedAliases = [ "@en" ];
        };
      };
    };
  };
}
