# What is this?
This repo contains all of my system configuration and some scripts to manage it. It likely won't run on your system unless it has an NVIDIA GPU and an identical file system layout. If you want to try, all system configuration is located in the system folder.
## Using this repository
Instead of attempting to apply this config to your own system, I suggest you use it to learn about Nix. This config is very simple in comparison to some others, but it isn't well commented and is actively changing as I change things on my system.

The users folder contains directories for each user managed by `home-manager`. Each has a `home.nix` containing all their config. If you want to add a user, you'll need to update `flake.nix`, which is the entrypoint for the configuration. 

Here are some things that looking through the repo could help you to do:
- Setting up NVIDIA drivers
- Setting up Hyprland window manager and cursors
- Using `nix-colors`
- Setting up credential management with git (see my `users/will/home.nix` and `system/configuration.nix`
- Setting up gnupg (see `system/configuration.nix`)
