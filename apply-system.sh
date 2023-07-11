#!/bin/sh
pushd ~/.dotfiles
sudo nix-rebuild switch -I nixos-config=./system/configuration.nix
popd
