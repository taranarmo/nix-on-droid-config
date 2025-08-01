{ config, lib, pkgs, nixvim, catppuccin, ... }:

{
  imports = [
    ./nixvim.nix
  ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.packages = with pkgs; [
    gemini-cli
  ];

  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  # insert home-manager config
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "colored-man-pages"
        "pass"
      ];
    };
  };
  programs.git = {
    enable = true;
    userName = "Sergey Volkov ";
    userEmail = "taranarmo@gmail.com";
    difftastic.enable = true;
  };
  programs.pay-respects.enable = true;
}
