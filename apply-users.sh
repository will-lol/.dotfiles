#!/bin/sh
pushd ~/.dotfiles
rm ~/.mozilla/firefox/default/search.json.mozlz4
nix build .#homeManagerConfigurations.will.activationPackage
./result/activate
popd
