{ config, lib, pkgs, catppuccin, ... }:

{
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

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
    settings.user = {
      name = "Sergey Volkov ";
      email = "taranarmo@gmail.com";
    };
  };
  programs.difftastic.git.enable = true;
  programs.pay-respects.enable = true;
}
