#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/will/home.nix
popd
