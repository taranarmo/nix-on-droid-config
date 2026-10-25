{ config, lib, pkgs, nix-index-database, catppuccin, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim

    # Some common stuff that people expect to have
    procps
    killall
    diffutils
    findutils
    util-linux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip

    python3
    julia
    ripgrep
    openssh
  ];
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixVersions.latest;
  };


  # Set your time zone
  time.timeZone = "Europe/Berlin";

  # Configure home-manager
  home-manager = {
    config = ./home/home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit nix-index-database catppuccin;
    };
    sharedModules = [
      nix-index-database.homeModules.nix-index
      catppuccin.homeModules.catppuccin
    ];
  };

  user.shell = "${pkgs.zsh}/bin/zsh";


  # TODO: re-enable once termux-am activity-manager wrapper works again
  # android-integration = {
  #   termux-setup-storage.enable = true;
  #   termux-open.enable = true;
  # };

}
