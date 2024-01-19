#!/bin/sh
pushd ~/.dotfiles
rm ~/.mozilla/firefox/default/search.json.mozlz4
sudo nixos-rebuild switch --flake .#
popd
