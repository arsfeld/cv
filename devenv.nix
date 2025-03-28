{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ 
    pkgs.just
    pkgs.typst 
    pkgs.font-awesome_5
    pkgs.font-awesome_6
    pkgs.roboto
    pkgs.source-sans-pro
    pkgs.source-sans
  ];
}
