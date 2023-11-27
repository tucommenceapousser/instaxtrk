{ pkgs }: {
  deps = [
    pkgs.tor
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}