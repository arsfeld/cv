{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = [
    pkgs.just
    pkgs.typst
    pkgs.gettext  # for envsubst
    pkgs.font-awesome
    pkgs.roboto
    pkgs.source-sans-pro
    pkgs.source-sans
  ];

  env.TYPST_FONT_PATHS = lib.concatStringsSep ":" [
    "${pkgs.font-awesome}/share/fonts"
    "${pkgs.roboto}/share/fonts"
    "${pkgs.source-sans-pro}/share/fonts"
    "${pkgs.source-sans}/share/fonts"
  ];
}
