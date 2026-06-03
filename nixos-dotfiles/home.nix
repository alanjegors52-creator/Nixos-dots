{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  
  # Standard .config/directory
  configs = {
    oxwm = "oxwm";
    nvim = "nvim";
    alacritty = "alacritty";
    picom = "picom";
    fastfetch = "fastfetch";
    rofi = "rofi";
  };
in
{
  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    librewolf
    rofi
    xwallpaper
    picom
    termusic
  ];

  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
      vim = "nvim"; # nvim just better ngl
      list-ent = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      del-ent = "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system"; # put yo generation number here or smth, like del-ent 1 2 3 etc
    };
  };

  # Moved out of bash.shellAliases and properly structured
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
