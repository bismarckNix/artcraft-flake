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

  wrapped = import ../lib/wrapper.nix { inherit lib pkgs; } {
    inherit name;
    inherit (cfg) package extraArgs environment xwayland;
  };

  settingsFormat = pkgs.formats.json { };
  base = app.configPath or ".config";
  configDir = "${lib.removeSuffix "/" base}/${name}";
  configFile = app.configFile or "preferences.json";

  declared = (pkgs.formats.json {}).generate "${name}-declared.json" cfg.settings;
in
{
  imports = [ (import ./options.nix { inherit self name; }) ];

  options.programs.artcraft.${name} = {
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
      example = lib.literalExpression ''
        {
          interface.appearanceMode = "dark";
        }
      '';
      description = ''
        Written to the app's config file. Free-form: keys are not validated.
        Empty means no file is managed.
      '';
    };

    desktopEntry = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create a launcher entry.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ wrapped ];

      # Merge the declared config with the default config.
      # Changes made via the GUI aren't overwritten,
      # unless you do so in your Nix configuration.
      activation = lib.optionalAttrs (!(app.noSettings or false) && cfg.settings != { }) {
        "${name}Preferences" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          dir="$HOME/"${lib.escapeShellArg configDir}
          file=${lib.escapeShellArg name}
          f="$dir/$file"
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
            # missing, empty, or invalid: start from the declared values
            install -m 644 ${declared} "$f"
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
        categories = [ "Graphics" ];
        terminal = false;
      }
    );
  };
}
