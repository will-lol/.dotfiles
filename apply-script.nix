{ pkgs }: pkgs.writeShellScriptBin "apply-system" ''
  pushd ~/.dotfiles
  rm ~/.mozilla/firefox/default/search.json.mozlz4
  sudo nixos-rebuild switch --flake ".#$1"
  popd
''
