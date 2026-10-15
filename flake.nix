{
  description = "ArtCraft open-source creative suite packaged for Nix";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  {
    self,
    nixpkgs,
    home-manager,
    ...
  }:
  let
    inherit (nixpkgs) lib;

    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

    apps = import ./apps.nix;
    names = builtins.attrNames apps;
    perApp = lib.genAttrs names;

    # { photocraft = <module>; filmcraft = <module>; ... } plus
    # `default` / `artcraft`, which import every app's module at once.
    withAll =
      mods:
      let
        all = {
          imports = builtins.attrValues mods ++ [
            (import ./modules/suite.nix { inherit names; })
          ];
        };
      in
      mods
      // {
        default = all;
        artcraft = all;
      };
  in
  {
    packages = forAllSystems (
      pkgs:
      let
        system = pkgs.stdenv.hostPlatform.system;
        available = lib.filterAttrs (_: app: (app.sources or { x86_64-linux = { }; }) ? ${system}) apps;
        appPackages = lib.mapAttrs (
          name: app: import ./lib/mk-package.nix { inherit pkgs name app; }
        ) available;
      in
      appPackages
      // rec {
        artcraft = pkgs.symlinkJoin {
          name = "artcraft";
          paths = builtins.attrValues appPackages;
        };
        default = artcraft;
      }
    );

    homeModules = withAll (
      perApp (
        name:
        import ./modules/hm.nix {
          inherit self home-manager name;
        }
      )
    );

    nixosModules = withAll (perApp (name: import ./modules/nixos.nix { inherit self name; }));
  };
}
