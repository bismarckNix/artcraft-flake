# Global option shared by the Home Manager and NixOS modules.
{
  lib,
  ...
}:
{
  options.programs.artcraft.launcherOnly = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Only create a launcher entry for the Craft Launcher. The other apps
      stay installed, just without desktop entries.
    '';
  };
}
