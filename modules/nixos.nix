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
  prefix = app.assetPrefix or app.displayName;

  appId = app.startupWMClass or "ai.storyteller.${app.assetPrefix or name}";
  entryId = if app.launcher or false then appId else name;

  wrapped = import ../lib/wrapper.nix { inherit lib pkgs; } {
    inherit name;
    inherit (cfg) package extraArgs environment xwayland;
  };

  iconPkg = pkgs.runCommand "${name}-icon" { } ''
    install -Dm644 ${icon} $out/share/icons/hicolor/scalable/apps/${iconName}.svg
  '';

  desktopItem = pkgs.makeDesktopItem ({
    name = entryId;
    desktopName = app.displayName;
    icon = iconName;
    comment = app.description;
    exec = "${wrapped}/bin/${name} %U";
    categories = app.categories or [ ];
    mimeTypes = app.mimeType or [ ];
    terminal = false;
    startupNotify = true;
    startupWMClass = app.startupWMClass or "ai.storyteller.${app.assetPrefix or name}";
  } // lib.optionalAttrs (icon != null) { inherit icon; });
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
    environment.systemPackages =
      [ wrapped iconPkg ]
      ++ lib.optional cfg.desktopEntry desktopItem

      # Add an icon for the launchers notifications
      ++ lib.optional (icon != null) (
        pkgs.runCommand "${name}-icon" { } ''
          install -Dm644 ${icon} $out/share/icons/hicolor/scalable/apps/ai.storyteller.${prefix}.svg
        ''
      );
  };
}
