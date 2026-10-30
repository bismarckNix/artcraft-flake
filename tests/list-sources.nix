# Lists every downloadable (package per system + icon) with its URL and declared hash.
# Mirrors the URL logic of lib/mk-package.nix and lib/icon.nix. Keep them in sync.
# Usage: nix eval --json --file tests/list-sources.nix
let
  apps = import ../apps.nix;
  inherit (builtins) attrNames concatLists match;

  entries =
    name: app:
    let
      owner = app.owner or "storytold";
      base = "https://github.com/${owner}";
      tag = app.tag or "v${app.version}";

      # Apps without `sources` only support x86_64-linux.
      sources = app.sources or { x86_64-linux = { hash = app.hash or null; }; };

      packageEntries = map (
        system:
        let
          s = sources.${system};
          arch = if match "aarch64-.*" system != null then "aarch64" else "x86_64";
          prefix = app.assetPrefix or name;
          default = "${prefix}-${app.version}-linux-${arch}.AppImage";
          asset = s.asset or (if system == "x86_64-linux" then app.asset or default else default);
        in
        {
          inherit name system;
          kind = "package";
          url = "${base}/${name}/releases/download/${tag}/${asset}";
          hash = s.hash or null;
        }
      ) (attrNames sources);

      iconUrl =
        app.iconUrl or "https://raw.githubusercontent.com/storytold/${name}/main/assets/app-icon/${name}.svg";

      iconEntries =
        if iconUrl == null then
          [ ]
        else
          [
            {
              inherit name;
              system = "-";
              kind = "icon";
              url = iconUrl;
              hash = app.iconHash or null;
            }
          ];
    in
    packageEntries ++ iconEntries;
in
concatLists (map (n: entries n apps.${n}) (attrNames apps))
