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
  appIcon = pkgs.fetchurl {
    url = app.iconUrl;
    hash = app.iconHash or lib.fakeHash;
    name = "${name}-icon.svg";
  };

  wrapped = import ../lib/wrapper.nix { inherit lib pkgs; } {
    inherit name;
    inherit (cfg) package extraArgs environment xwayland;
  };
in
{
  imports = [ (import ./options.nix { inherit self name; }) ];

  options.programs.artcraft.${name}.desktopEntry = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Install a launcher entry.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      wrapped
    ]
    ++ lib.optional cfg.desktopEntry (
      pkgs.makeDesktopItem {
        inherit name;
        icon = appIcon;
        desktopName = app.displayName;
        exec = "${wrapped}/bin/${name} %U";
        categories = [ "Graphics" ];
        terminal = false;
      }
    );
  };
}
