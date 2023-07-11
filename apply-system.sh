#!/bin/sh
pushd ~/.dotfiles
sudo nix-rebuild switch --flake .#
popd
