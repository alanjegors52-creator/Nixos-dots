{ config, pkgs, ... }:

{
  home.username = "alan";
  home.homeDirectory = "/home/alan";
  programs.git.enable = true;

  home.file.".config/alacritty".source = ./config/alacritty;  
  home.file.".config/fastfetch".source = ./config/fastfetch;
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alan/nixos-dotfiles/config/nvim";
    recursive = true;
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    librewolf
    dmenu
    nemo
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
}
