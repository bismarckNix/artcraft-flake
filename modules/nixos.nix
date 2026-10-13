# Global NixOS module.
{
  self,
  name
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  app = (import ../apps.nix).${name};
  cfg = config.programs.artcraft.${name};
  icon = import ../lib/icon.nix { inherit lib pkgs name app; };

  wrapped = import ../lib/wrapper.nix { inherit lib pkgs; } {
    inherit name;
    inherit (cfg) package extraArgs environment xwayland;
  };
in
{
  imports = [
    ./launcher-only.nix
    (import ./options.nix { inherit self name; })
  ];

  options.programs.artcraft.${name}.desktopEntry = lib.mkOption {
    type = lib.types.bool;
    default = !config.programs.artcraft.launcherOnly || (app.launcher or false);
    defaultText = lib.literalExpression "!launcherOnly || isLauncher";
    description = "Create a launcher entry.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      wrapped
    ] ++
      lib.optional cfg.desktopEntry desktopItem;
  };
}
