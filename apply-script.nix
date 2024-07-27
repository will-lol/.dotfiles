{pkgs}:
pkgs.writeShellScriptBin "apply-system" ''
  pushd ~/.dotfiles
  rm ~/.mozilla/firefox/default/search.json.mozlz4
  sudo nixos-rebuild switch --show-trace --upgrade --log-format internal-json -v --flake ".#$1" |& ${pkgs.nix-output-monitor}/bin/nom --json
  popd
''
