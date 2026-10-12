# Options shared by the Home Manager and NixOS modules:
#   programs.artcraft.<name>.{enable,package,extraArgs,environment,xwayland}
{
  self,
  name
}:
{
  lib,
  pkgs,
  ...
}:
let
  app = (import ../apps.nix).${name};
in
{
  options.programs.artcraft.${name} = {
    enable = lib.mkEnableOption app.displayName;

    package = lib.mkOption {
      type = lib.types.package;
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.${name};
      defaultText = lib.literalExpression "inputs.artcraft.packages.\${system}.${name}";
      description = "The ${app.displayName} package to install.";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "--some-flag" ];
      description = "Extra command-line arguments passed on every launch.";
    };

    environment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      example = {
        WGPU_BACKEND = "vulkan";
      };
      description = "Environment variables set for the app.";
    };

    xwayland = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Run under XWayland by unsetting WAYLAND_DISPLAY. Needed for drag and
        drop on Wayland, and requires an XWayland server to be available.
      '';
    };
  };
}
