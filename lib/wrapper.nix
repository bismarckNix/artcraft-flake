# Applies extraArgs / environment / xwayland to a package's main binary.
# Returns the package untouched when there is nothing to apply.
{
  lib,
  pkgs
}:
{
  name,
  package,
  extraArgs ? [ ],
  environment ? { },
  xwayland ? false,
}:
let
  flags = lib.concatStringsSep " " (
    lib.mapAttrsToList (n: v: "--set ${n} ${lib.escapeShellArg v}") environment
    ++ lib.optional xwayland "--unset WAYLAND_DISPLAY"
    ++ lib.optional (extraArgs != [ ]) "--add-flags ${lib.escapeShellArg (lib.escapeShellArgs extraArgs)}"
  );
in
if flags == "" then
  package
else
  pkgs.symlinkJoin {
    name = "${name}-wrapped";
    paths = [ package ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/${name} ${flags}";
    meta = package.meta or { };
  }
