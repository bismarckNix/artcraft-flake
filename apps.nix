# ArtCraft app entries. If you want to add an app, add an entry here.
#
# Fields:
#   displayName    shown in launchers
#   description    package description
#   iconUrl        launcher icon url, deafults to
#                  https://raw.githubusercontent.com/storytold/${name}/main/assets/app-icon/${name}.svg,
#                  removes the app icon if set to null
#   version        release version (no leading "v")
#   hash/iconHash  fixed-output hash of the AppImage/icon; null = fake hash
#   tag            release tag (default "v${version}")
#   owner          the owner of the repository, defaults to storytold
#   assetPrefix    AppImage file name
#                  (default "${name}-${version}-linux-x86_64.AppImage")
#   extraPkgs      p: [ p.somelib ]  extra libs inside the FHS wrapper
#   configName     config directory name, defaults to the ${name}
#   configPath     config path relative to $XDG_CONFIG_HOME, default to ~/.config/${name}
#   prefsFile      config file name, defaults to prefs.json; null - disabled
#   uiFile         ui file name, defaults to ui.json; null = disabled
#   noSettings     disables settings
#                  (should only be used for apps that don't have a settings format that doesn't work well with Nix, e. g. .ron)
#
#   categories     the mimeapps categories (e.g. graphics, editor, etc.)
#   mimeType       the mimeType (e.g. image/png, video/mp4, etc.)

{
  craft-launcher = rec {
    displayName = "Craft Launcher";
    description = "The Craft App Launcher";
    version = "0.13.0";
    assetPrefix = "artcraft-launcher";
    iconUrl = "https://raw.githubusercontent.com/storytold/craft-launcher/refs/heads/main/assets/app-icon/artcraft-launcher.svg";
    sources = {
      x86_64-linux.hash = "sha256-Dd/MbHA7mlz3gpV1DhA7IHbVRLsmM8cs5Mq1ISMm2N4=";
      aarch64-linux.hash = "sha256-BgbPmGc4D0axyf/wU5cr/fkBCTuUwv5VLpkn6DxxG+c=";
    };
    iconHash = "sha256-+Hr4G2+kEdqIIO7Sv9zFTA7pzUU7ToaMZPVsadsULQ4=";
    configPath = ".local/share";
    configName = "ai.storyteller.artcraft-launcher";
    noSettings = true;
    ronFile = "app.ron";   # Ron configuration is techically possible, but it's not as flexible
    ronOptions = {         # and reliable as json, therefore it is not supported, except for specific options
      notifyUpdates = "notify";
      trayIcon = "close_to_tray";
    };
    launcher = true;   # This makes the app desktop entry not be disabled by the launcherOnly option
    categories = [ "Utility" "PackageManager" ];
  };

  photocraft = rec {
    displayName = "PhotoCraft";
    description = "An open-source, photo editor written by scratch in pure Rust";
    version = "0.19.0";
    sources = {
      x86_64-linux.hash = "sha256-DNMLNm1ACQq6AbCh/gIb3PwCsR/5FRx6rO1bZj25uFY=";
      aarch64-linux.hash = "sha256-dV16oHyWaZXK8VT+3KXe4MHLyPXHwmecZ6i+bWRnMi0=";
    };
    iconHash = "sha256-pIMzt7eUtwFY2pOiYthPuC9fu/dELbYPI1oKaRNqHOI=";
    prefsFile = "preferences.json";
    uiFile = null;
    categories = [ "Graphics" "2DGraphics" "RasterGraphics" "Photography" ];
    mimeType = [
      "application/x-photocraft" "image/vnd.adobe.photoshop" "image/x-psd" "image/x-psb"
      "image/png" "image/jpeg" "image/tiff" "image/webp" "image/gif" "image/bmp"
      "image/x-tga" "image/x-icon" "image/vnd.microsoft.icon"
      "image/x-portable-anymap" "image/x-portable-bitmap" "image/x-portable-graymap"
      "image/x-portable-pixmap" "image/x-exr" "image/vnd.radiance" "image/avif" "image/qoi"
    ];
  };

  vectorcraft = rec {
    displayName = "VectorCraft";
    description = "An open-source, vector art tool written by scratch in pure Rust";
    version = "0.20.0";
    sources = {
      x86_64-linux.hash = "sha256-tiW66AVY+V2Uuc0M50Ik0qgxgBBtqyYZVZVRyrIW6tQ=";
      aarch64-linux.hash = "sha256-onoHMnBSk/UJKtvk2uoZqWjFLYI/FN/gmQn1ISqtkJE=";
    };
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "image/svg+xml" "application/pdf" ];
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.16.0";
    sources = {
      x86_64-linux.hash = "sha256-wr4bZUpt+YCHAhOQF4VlYHUkfk6OUwVFqXiG3sSi8FA=";
      aarch64-linux.hash = "sha256-wBbi5VDe3jdsodXxUgp/0E3j/fqIVh6FAvsBGMyy3QE=";
    };
    iconHash = "sha256-TvQVY5ZG4XNH+Z+0YiCmA9AkepjFVFu8gtLyUyX+a54=";
    configPath = ".local/share";
    prefsFile = "preferences.json";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "AudioVideoEditing" ];
    mimeType = [ "application/x-filmcraft" "video/mp4" "video/x-m4v"
      "video/quicktime" "video/x-matroska" "video/webm" "video/vnd.avi"
      "video/x-msvideo" "application/mxf" "video/mp2t" "video/mpeg" "video/3gpp"
    ];
  };

  lightcraft = {
    displayName = "LightCraft";
    description = "An open-source non-destructive photo editor written by scratch in pure Rust";
    version = "0.17.0";
    sources = {
      x86_64-linux.hash = "sha256-5ZKiepStIKCguu54k+ktkHnsQSSV+YepwIVLmewAshs=";
      aarch64-linux.hash = "sha256-w/Csop4S/Ge+PD/iInOaJRR5Xbklv/levF9FDjlQrt8=";
    };
    iconHash = "sha256-EnhY5ZQgcEbHvppl0cQgu80VIujAaP7NwxAI+SPcnG0=";
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "RasterGraphics" "Photography" ];
    mimeType = [
      "image/jpeg" "image/png" "image/tiff" "image/webp" "image/x-adobe-dng"
      "image/x-sony-arw" "image/x-canon-cr2" "image/x-canon-cr3"
      "image/x-nikon-nef" "image/x-fuji-raf" "image/x-olympus-orf"
      "image/x-panasonic-rw2" "image/x-panasonic-rw" "image/x-pentax-pef"
    ];
  };

  pdfcraft = {
    displayName = "PdfCraft";
    description = "An open-source PDF reader and editor written by scratch in pure Rust";
    version = "0.17.0";
    sources = {
      x86_64-linux.hash = "sha256-kzflcC7mRZ2LzamHbDrjyXJa84x0QJbbwHDXz64kRYY=";
      aarch64-linux.hash = "sha256-JQxCfV9QMhuEU985e8dtTs1TzcA4E/Ami2zo97QxoF8=";
    };
    iconHash = "sha256-J3RcAhgw+CwDOw8V8tjZ+OCZE4dDKXiH/34snn7Qado=";
    noSettings = true;     # Unfortunetly, this currently uses .ron format,  which isn't compatible with Nix
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
    };

  effectcraft = {
    displayName = "EffectCraft";
    description = "An open-source motion graphics and compositing tool written by scratch in pure Rust";
    version = "0.20.0";
    sources = {
      x86_64-linux.hash = "sha256-bMranKi1QRS3n3uZwzpRWj5LVKm6ukPrQ06IXk21pfc=";
      aarch64-linux.hash = "sha256-AhlGYxSGp5cNuCS1FaJ17pW+PttYT5ru+YbjYXHCnNs=";
    };
    iconHash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  designcraft = {
    displayName = "DesignCraft";
    description = "An open-source page and layout design editor written by scratch in pure Rust";
    version = "0.16.0";
    sources = {
      x86_64-linux.hash = "sha256-7MzaXcOMbKXeGS5FDxv6U5O0O9aDhosOUwauLcl1yCc=";
      aarch64-linux.hash = "sha256-RAHrwhCu6oEFXAKv5SngMq8pbPxT/S49fkSZNlzBVvc=";
    };
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    categories = [ "Graphics" "Publishing" ];
  };

  figcraft = {
    displayName = "FigCraft";
    description = "An open-source, clean-room reimplementation of collaborative design workflows in pure Rust";
    version = "0.14.0";
    sources = {
      x86_64-linux.hash = "sha256-j1MY8QALT346d4lejF2wNh1WMGrCvBPmCy0jaaLQ20c=";
      aarch64-linux.hash = "sha256-7dlQNqtxaOPwexlGO61c9LQz7ieb1OKKFUFLXy1nffY=";
    };
    iconHash = "sha256-YQw68ZTWoI/dqj8VaTfftQqwbJ/rZYYst+uxFEZaMkM=";
    configName = "FigCraft";
    prefsFile = "state.json";
    uiFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" "X-Design" ];
    mimeType = [
      "application/x-figcraft" "image/svg+xml" "image/png"
      "image/jpeg" "x-scheme-handler/figcraft"
    ];
  };

  wordcraft = {
    displayName = "WordCraft";
    description = "An open-source, clean-room reimplementation of Microsoft Word in pure Rust";
    version = "0.14.0";
    sources = {
      x86_64-linux.hash = "sha256-56L+4FzoYv6RR7brCrbNqeJsq6cpcWhGKAAiHmZjsls=";
      aarch64-linux.hash = "sha256-7qQekfKiMBRpxotPWNHQkxhGNky6teC5skrYlqeu0l8=";
    };
    iconHash = "sha256-mmjLf30R335QARJdO9f60vXMTc2x32YAbLz66IfmG0Y=";
    prefsFile = null;
    categories = [ "Office" "WordProcessor" ];
    mimeType = [
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/vnd.ms-word.document.macroEnabled.12"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
      "application/vnd.ms-word.template.macroEnabled.12" "application/msword"
      "application/msword-template" "application/vnd.oasis.opendocument.text"
      "application/rtf" "text/rtf" "text/markdown" "text/x-tex" "text/html" "text/plain"
    ];
  };

  soundcraft = {
    displayName = "SoundCraft";
    description = "An open-source, clean-room reimplementation of Avid Pro Tools in pure Rust";
    version = "0.16.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-UHmI92jehJZ2RzPl5xXgJ5hvlQqEWj6BJK+SqIX1t1Y=";
      aarch64-linux.hash = "sha256-2ufyzmNKoGjh9EXuFvCDTmIhxCeos8O9RZSDOVGT/Ww=";
    };
    iconHash = "sha256-NNwZQivzPcVyOezsAYBL9uoIUTiTF75v6bINEhduPBI=";
    prefsFile = null;
    categories = [
      "AudioVideo" "Audio" "Midi"
      "Mixer" "Sequencer" "Recorder"
    ];
    mimeType = [
      "application/x-soundcraft-session" "audio/x-wav" "audio/wav"
      "audio/vnd.wave" "audio/x-aiff" "audio/aiff" "audio/flac"
      "audio/x-flac" "audio/mpeg" "audio/midi" "audio/x-midi"
    ];
  };

  deckcraft = {
    displayName = "DeckCraft";
    description = "An open-source, clean-room reimplementation of Microsoft PowerPoint in pure Rust";
    version = "0.14.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/deckcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/ai.storyteller.deckcraft.svg";
    sources = {
      x86_64-linux.hash = "sha256-yeBa8lHYqwsH9gSN+B1BgWFAeVafiu1jgORMYbXrpjU=";
      aarch64-linux.hash = "sha256-6n8WZ81pcIUxmZ5LgMWfMCsXZYPES/NW0FEKHgMklYk=";
    };
    iconHash = "sha256-I+7cR+FM6m9MxnJLE67D5mjk4Bd/bO4fBy9Cg4Xg5t0=";
    categories = [ "Office" "Presentation" ];
    mimeType = [
      "application/x-deckcraft"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/vnd.openxmlformats-officedocument.presentationml.template"
      "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
    ];
  };

  cadcraft = {
    displayName = "CADCraft";
    description = "An open-source, clean-room AutoCAD-style app in pure Rust";
    version = "0.16.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
    sources = {
      x86_64-linux.hash = "sha256-B0b85ZL45u38zkEVkK6OEPL2hGs192XmO7EHHujI7qg=";
      aarch64-linux.hash = "sha256-DRaNweejjdOEPnfLd/sG/uL/MIg44tf5EXKvuUfF5/w=";
    };
    iconHash = "sha256-99cPBgscUQDnZvQbthaOPqyOtwwhkUxYQM1NiRAFI0E=";
    noSettings = true;   # Same story as PdfCraft - the config is in .ron format
    categories = [ "Graphics" "Engineering" "VectorGraphics" ];
    mimeType = [
      "image/vnd.dxf" "image/vnd.dwg"
      "application/x-dxf" "application/acad"
    ];
  };

  gridcraft = {
    displayName = "GridCraft";
    description = "An open-source, clean-room spreadsheet (Microsoft Excel-style) in pure Rust";
    version = "0.15.0";
    sources = {
      x86_64-linux.hash = "sha256-3Hibq+/11XyARNSnenUC6PguKTxAmfblGTnH1Qskv9w=";
      aarch64-linux.hash = "sha256-mfvuKZ8nFHrw2+/rwh1tsjphZtPslGNcTQPVXixq7lM=";
    };
    iconHash = "sha256-pMVfL1KJOzGYYrYQwAavg9qfCXpBErWpgri6lfQ9KFA=";
    categories = [ "Office" "Spreadsheet" ];
    mimeType = [
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.ms-excel.sheet.macroEnabled.12"
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
      "application/vnd.oasis.opendocument.spreadsheet" "text/csv"
      "text/tab-separated-values"
    ];
  };

  solidcraft = {
    displayName = "SolidCraft";
    description = "Parametric 3D CAD: sketch, constrain, extrude, and change a parameter to rebuild";
    version = "0.30.0";
    owner = "tangency-labs";
    sources = {
      x86_64-linux.hash = "sha256-qxJbpRD+Av4zb7JFl8LKFX5AwNsPrAhfcqMs+1MM9Vk=";
      aarch64-linux.hash = "sha256-eoZWvP+GCzUYt3/gjMrBCg5XMKRjq67LaQx6KM4CJeU=";
    };
    iconUrl = "https://raw.githubusercontent.com/tangency-labs/solidcraft/refs/heads/main/assets/icons/app/linux/exports/hicolor/256x256/apps/io.tangencylabs.solidcraft.png";
    iconHash = "sha256-caPkknIFcc9XL6pR2Gp/916dfeoJFhQrUd6DW/hXxa8=";
    noSettings = true;
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
    mimeType = [
      "application/x-solidcraft" "model/step"
      "model/iges" "model/stl" "model/3mf"
    ];
  };
}
