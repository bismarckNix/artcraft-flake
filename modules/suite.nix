# programs.artcraft.fullSuite.enable: turns on every app in apps.nix. Individual apps can be disabled with programs.artcraft.<app>.enable = false.
{ names }:
{
  config,
  lib,
  ...
}:
{
  options.programs.artcraft.fullSuite.enable = lib.mkEnableOption "every ArtCraft app";

  config.programs.artcraft = lib.mkIf config.programs.artcraft.fullSuite.enable (
    lib.genAttrs names (_: {
      enable = lib.mkDefault true;
    })
  );
}
