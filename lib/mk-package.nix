# Wraps one release AppImage as a Nix package.
{
  pkgs,
  name,
  app,
}:
let
  inherit (pkgs) lib stdenv;
  inherit (stdenv.hostPlatform) system isAarch64;

  sources = app.sources or { x86_64-linux = { inherit (app) hash; }; };
  source = sources.${system};

  arch = if isAarch64 then "aarch64" else "x86_64";
  defaultAsset = "${name}-${app.version}-linux-${arch}.AppImage";
  asset = source.asset or (if system == "x86_64-linux" then app.asset or defaultAsset else defaultAsset);
  tag = app.tag or "v${app.version}";
in
pkgs.appimageTools.wrapType2 {
  pname = name;
  inherit (app) version;

  src = pkgs.fetchurl {
    url = "https://github.com/storytold/${name}/releases/download/${tag}/${asset}";
    hash = if app.hash == null then lib.fakeHash else app.hash;
  };

  extraPkgs =
    p:
    [
      p.jq
      p.pkg-config
      p.openssl
      p.libxkbcommon
      p.libx11
      p.libxcursor
      p.libxrandr
      p.libxi
      p.libxcb
      p.libGL
      p.vulkan-loader
      p.mesa
      p.wayland
      p.wayland-protocols
      p.fontconfig
      p.freetype
      p.alsa-lib
      p.zlib
    ]
    ++ (app.extraPkgs or (_: [ ])) p;

  meta = {
    inherit (app) description;
    homepage = "https://github.com/storytold/${name}";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = name;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = builtins.attrNames sources;
  };
}
