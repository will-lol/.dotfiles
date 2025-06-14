{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    languagePacks = [ "en-GB" ];
    profiles.default = {
      id = 0;
      isDefault = true;
      settings = {
        # sidebar
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;

        "devtools.everOpened" = true;
        "intl.regional_prefs.use_os_locales" = true;
        "intl.accept_languages" = "en-GB, en";
        "browser.toolbars.bookmarks.visibility" = "never";
        "media.ffmpeg.vaapi.enabled" = true;
        "signon.rememberSignons" = false;
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "app.update.auto" = false;
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 0;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.feeds.topsites" = false;

        # fastfox things
        "content.notify.interval" = 1000;
        "gfx.canvas.accelerated.cache-items" = 4096;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;
        "browser.cache.jsbc_compression_level" = 3;
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;
        "image.mem.decode_bytes_at_a_time" = 32768;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.ssl_tokens_cache_capacity" = 10240;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;
        "dom.enable_web_task_scheduling" = true;
        "dom.security.sanitizer.enabled" = true;

        # securefox things
        "browser.contentblocking.category" = "strict";
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "dom.security.https_first" = true;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        # peskyfox things
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
      };
      containersForce = true;
      containers = {
        work = {
          id = 1;
          icon = "briefcase";
          color = "orange";
        };
        personal = {
          id = 2;
          icon = "fingerprint";
          color = "blue";
        };
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          multi-account-containers
          firefox-translations
          vimium
          bitwarden
          british-english-dictionary-2
          temporary-containers
          granted
          (buildFirefoxXpiAddon {
            pname = "automatic-adskipper";
            version = "4.1";
            addonId = "miletadulovic98@gmail.com";
            url = "https://addons.mozilla.org/firefox/downloads/file/4411263/automatic_adskipper-4.1.xpi";
            sha256 = "bb3dc1ef419cb9bd3d231b4f7c66ee0742503a0b3631c3e720960d18867d7994";
            meta = with pkgs.lib; {
              homepage = "https://www.adskipper.me";
              description = "AdSkipper is browser extension that automatically skips in video ads on websites. \n\nSupport the project on:\n<a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/b14c8e45a91db2662ff71cedb888892d794f9ec116a52763b69fa83bc39967b5/https%3A//www.buymeacoffee.com/mileta\" rel=\"nofollow\">https://www.buymeacoffee.com/mileta</a>\n<a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/591feb7cd4b5d3b7c85ca86f90a6aab5f9a7e55c0264515b651dbd1b10365420/https%3A//patreon.com/MiletaDulovic\" rel=\"nofollow\">https://patreon.com/MiletaDulovic</a>\n\nSource Code\n<a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/a6c2e4d70815f1cf580713a85fdb5152b5c25a6b29cbdcad3b2142c235a6fd70/https%3A//github.com/M1ck0/adskipper-extension\" rel=\"nofollow\">https://github.com/M1ck0/adskipper-extension</a>";
              license = licenses.mit;
              mozPermissions = [
                "storage"
                "*://*.youtube.com/*"
              ];
              platforms = platforms.all;
            };
          })
          (buildFirefoxXpiAddon {
            pname = "what-to-click";
            version = "1.12.5";
            addonId = "{7feef224-a737-4d04-b0c1-ea47d4cad70a}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4159230/what_to_click-1.12.5.xpi";
            sha256 = "8eccdf9d8ece5cc759f77b7628201590d57a98cc8d2335666a38bfef87fc0e4e";
            meta = { };
          })
          (buildFirefoxXpiAddon {
            pname = "tabwrangler";
            version = "7.5.1";
            addonId = "{81b74d53-9416-4fb3-afa2-ab46684b253b}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4292157/tabwrangler-7.5.1.xpi";
            sha256 = "2e6f4ca2a3a2ea7380edad7a769fc0631e0c874c686fd4f5a0de16310cf25323";
            meta = with pkgs.lib; {
              homepage = "https://github.com/tabwrangler/tabwrangler/";
              description = "Automatically closes inactive tabs and makes it easy to get them back";
              license = licenses.mit;
              mozPermissions = [
                "alarms"
                "contextMenus"
                "sessions"
                "storage"
                "tabs"
              ];
              platforms = platforms.all;
            };
          })
        ];
      };
      search.force = true;
      search.engines = {
        nixpkgs = {
          name = "nixpkgs";
          urls = [
            {
              template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
            }
          ];
          definedAliases = [ "@nix" ];
        };
        github-will-lol = {
          name = "Will Lucky";
          urls = [ { template = "https://github.com/will-lol/{searchTerms}"; } ];
          definedAliases = [ "@willl" ];
        };
        reddit-subreddit = {
          name = "Reddit - subreddit";
          urls = [ { template = "https://www.reddit.com/r/{searchTerms}"; } ];
          definedAliases = [ "r/" ];
        };
        reddit = {
          name = "Reddit";
          urls = [ { template = "https://www.reddit.com/search/?q={searchTerms}"; } ];
          definedAliases = [ "@reddit" ];
        };
        github = {
          name = "GitHub";
          urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
          definedAliases = [ "@github" ];
        };
        dictionary = {
          name = "Dictionary";
          urls = [
            {
              template = "https://www.oed.com/search/dictionary/?q={searchTerms}";
            }
          ];
          definedAliases = [ "@dict" ];
        };
        es = {
          name = "Translate from Spanish";
          urls = [
            {
              template = "https://translate.google.com/?sl=es&tl=en&text={searchTerms}&op=translate";
            }
          ];
          definedAliases = [ "@es" ];
        };
        en = {
          name = "Translate from English";
          urls = [
            {
              template = "https://translate.google.com/?sl=en&tl=es&text={searchTerms}&op=translate";
            }
          ];
          definedAliases = [ "@en" ];
        };
      };
    };
  };
}
