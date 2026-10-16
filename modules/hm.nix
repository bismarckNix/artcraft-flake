# Home Manager module for one app: programs.artcraft.<name>
{
  self,
  name,
  home-manager ? null,
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

  wrapped = import ../lib/wrapper.nix { inherit lib pkgs; } {
    inherit name;
    inherit (cfg) package extraArgs environment xwayland;
  };

  settingsFormat = pkgs.formats.json { };
  configDir = "${lib.removeSuffix "/" (app.configPath or ".config")}/${app.configName or name}";

  prefsFile = app.prefsFile or "prefs.json";
  hasPrefs = prefsFile != null;
  uiFile = app.uiFile or "ui.json";
  hasUi = uiFile != null;

  mergeScript = file: attrs:
    let declared = settingsFormat.generate "${name}-${file}" attrs; in ''
      dir="$HOME/"${lib.escapeShellArg configDir}
      f="$dir/"${lib.escapeShellArg file}
      mkdir -p "$dir"

      if [ -s "$f" ] && ${pkgs.jq}/bin/jq -e . "$f" >/dev/null 2>&1; then
        tmp="$(mktemp "$f.XXXXXX")"
        if ${pkgs.jq}/bin/jq --slurpfile d ${declared} '. * $d[0]' "$f" > "$tmp"; then
          mv "$tmp" "$f"
        else
          rm -f "$tmp"
          echo "artcraft.${name}: merge failed, left $f untouched" >&2
        fi
      else
        install -m 644 ${declared} "$f"
      fi
    '';

  ronOptions = app.ronOptions or { };

  ronScript = lib.concatStringsSep "\n" (lib.mapAttrsToList (opt: key:
    lib.optionalString (cfg.${opt} != null) ''
      ${pkgs.gnused}/bin/sed -i -E 's/([(,{[:space:]])${key}([[:space:]]*:[[:space:]]*)(true|false)/\1${key}\2${lib.boolToString cfg.${opt}}/' "$f"
    '') ronOptions);

  managed = lib.optionalAttrs (!(app.noSettings or false)) (
    lib.filterAttrs (_: f: f.file != null && f.attrs != { }) {
      Preferences = { file = prefsFile; attrs = cfg.settings or { }; };
      Ui = { file = uiFile; attrs = cfg.uiSettings or { }; };
    }
  );
in
{
  imports = [
    ./launcher-only.nix
    (import ./options.nix { inherit self name; })
  ];

  options.programs.artcraft.${name} =
  {
    desktopEntry = lib.mkOption {
      type = lib.types.bool;
      default = !config.programs.artcraft.launcherOnly || (app.launcher or false);
      defaultText = lib.literalExpression "!launcherOnly || isLauncher";
      description = "Create a launcher entry.";
    };
  }
  // lib.optionalAttrs hasPrefs {
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
      description = "Merged into ${prefsFile}. Free-form, keys are not validated.";
    };
  }
  // lib.optionalAttrs hasUi {
    uiSettings = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
      description = "Merged into ${uiFile}. Free-form, keys are not validated.";
    };
  }
  // lib.mapAttrs (_: key: lib.mkOption {
    type = lib.types.nullOr lib.types.bool;
    default = null;
    description = "Sets `${key}` in ${app.ronFile}. Null leaves it alone.";
  }) ronOptions;

  config = lib.mkIf cfg.enable {
    home = {
      # Add an icon for the launchers notifications
      packages = [ wrapped ] ++ lib.optional (icon != null) (
        pkgs.runCommand "${name}-icon" { } ''
          install -Dm644 ${icon} $out/share/icons/hicolor/scalable/apps/${prefix}.svg
        ''
      );

      # Merge the declared config with the default config.
      # Changes made via the GUI aren't overwritten,
      # unless you do so in your Nix configuration.
      activation = lib.mapAttrs' (kind: f:
        lib.nameValuePair "${name}${kind}"
          (lib.hm.dag.entryAfter [ "writeBoundary" ] (mergeScript f.file f.attrs))
      ) managed
      // lib.optionalAttrs (ronOptions != { }) {
        "${name}Ron" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          f="$HOME/"${lib.escapeShellArg configDir}"/"${lib.escapeShellArg app.ronFile}
          if [ -f "$f" ]; then
            ${ronScript}
          fi
        '';
      };
    };

    xdg.desktopEntries.${name} = lib.mkIf cfg.desktopEntry (
      lib.mkDefault {
        name = app.displayName;
        inherit icon;
        comment = app.description;
        exec = "${wrapped}/bin/${name} %U";
        categories = app.categories or [];
        mimeType = app.mimeType or [];
        terminal = false;
        startupNotify = true;
      }
    );
  };
}
