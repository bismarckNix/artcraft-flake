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
    version = "0.10.0";
    assetPrefix = "artcraft-launcher";
    iconUrl = "https://raw.githubusercontent.com/storytold/craft-launcher/refs/heads/main/assets/app-icon/artcraft-launcher.svg";
    sources = {
      x86_64-linux.hash = "sha256-LH8/nHPdlEUx3wc+pugAz/W6nVM9AP8fABVHDvF0Eq0=";
      aarch64-linux.hash = "sha256-A/QSZbaPIs76f7t94uPGNf0qFVkshGxGavmazONmbLE=";
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
    version = "0.17.0";
    sources = {
      x86_64-linux.hash = "sha256-zncpnyQ1NKwdJIqoHJqf0niuQHwCTLkx4Dkx63C+VK8=";
      aarch64-linux.hash = "sha256-j28026GmiAKhVBORctgOajEHWaeKdfAtOdWybM8zhOs=";
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
    version = "0.18.0";
    sources = {
      x86_64-linux.hash = "sha256-ng1If8cbEi6W8ZsTbTrNs4XqpAn21KgDRVfyNWLyEIo=";
      aarch64-linux.hash = "sha256-QxKRfcBwTYln0cPTf8OFTVrhNWMcF7tMy4EawTc6st8=";
    };
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "image/svg+xml" "application/pdf" ];
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.14.0";
    sources = {
      x86_64-linux.hash = "sha256-EzuLiNtt7j+kfdOfwcndkigoOAaje5UVh8xjZa7Jo9M=";
      aarch64-linux.hash = "sha256-tuRH3xfvs63ogNQSoMOFUXcyDcS4zukNOV00PJ+0QsQ=";
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
    version = "0.15.0";
    sources = {
      x86_64-linux.hash = "sha256-hR8cFVT9qSj+Qz6cvg4TmjkyMVZVYcLlFStyC7BZgTs=";
      aarch64-linux.hash = "sha256-F7VBOMEbR4FVgOGepRKPQageM9mLfJfCmoEIufyKKRk=";
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
    version = "0.15.0";
    sources = {
      x86_64-linux.hash = "sha256-fXdxpiqcgeNbHeKGrTgRDIWlmgQMErlh8CTulyM40v4=";
      aarch64-linux.hash = "sha256-xDAQN4+RgIh2ROqlrYzJ/5FocU4KEI9J5iosG3vgEqA=";
    };
    iconHash = "sha256-UrOEoQoqf90xRdmCKXLP1WjvDLcxJUm9Q5mt3YnUWm0=";
    noSettings = true;     # Unfortunetly, this currently uses .ron format,  which isn't compatible with Nix
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
    };

  effectcraft = {
    displayName = "EffectCraft";
    description = "An open-source motion graphics and compositing tool written by scratch in pure Rust";
    version = "0.18.0";
    sources = {
      x86_64-linux.hash = "sha256-Bx+OtCvmOnhiEX05n5bX7UzFuQrB0Gtrq5k3DQzUraM=";
      aarch64-linux.hash = "sha256-vuOn+Ncghp35+SdrPfL45/VOi56WGrKWZl8kpweLbUg=";
    };
    iconHash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  designcraft = {
    displayName = "DesignCraft";
    description = "An open-source page and layout design editor written by scratch in pure Rust";
    version = "0.14.0";
    sources = {
      x86_64-linux.hash = "sha256-x7mkt2DkyUsF/eTNHCZoI6c2vD+lBxUM/w3Bkg7fwo4=";
      aarch64-linux.hash = "sha256-qjQu22VDSHKQ6Bpj1h/Twx/AOIdfd+LHhthEGctF0EU=";
    };
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    categories = [ "Graphics" "Publishing" ];
  };

  figcraft = {
    displayName = "FigCraft";
    description = "An open-source, clean-room reimplementation of collaborative design workflows in pure Rust";
    version = "0.12.1";
    sources = {
      x86_64-linux.hash = "sha256-xSvgRte+pzeQ81hP/KbseTXfIprc6Pjkg7AyQu4qqx8=";
      aarch64-linux.hash = "sha256-N2v+/m5ZZ3UofKKd8eQ31DiR2VRVmltu03LmDPKP+mA=";
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
    version = "0.12.0";
    sources = {
      x86_64-linux.hash = "sha256-0HMAJNtslp5566qcyavN+7GY6pspyb0KKgT5g052Vss=";
      aarch64-linux.hash = "sha256-SwGZP2JO3fyQ+rinXKk7nTwiQnWX8DOARNEbp++2HMU=";
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
    version = "0.14.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-4fLu4WxtpZ2yPAck6XmSApvcOhmo5kcEdT05jbeDI4c=";
      aarch64-linux.hash = "sha256-SYgmqDFeRsSGLwSdcF7MfISfyxVdtc0NUEjLK73FgEk=";
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
    version = "0.12.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/deckcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/ai.storyteller.deckcraft.svg";
    sources = {
      x86_64-linux.hash = "sha256-KW0+avxRZnqGPLGJwsOXL+5rnGQWSEy+CbDefzh26jo=";
      aarch64-linux.hash = "sha256-fSSiJaUV2WmVJQBUP+kTZ6lWD0iPsyfIa0Lz72kMthw=";
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
    version = "0.14.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
    sources = {
      x86_64-linux.hash = "sha256-0FTldp7hgTRpjQdzR2hxyt2JSRqRUjw+slioJia7mec=";
      aarch64-linux.hash = "sha256-HAni+Nt7vmtwnQpeymB+dT/LJmtU6PqDt+fAP5rJS/w=";
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
    version = "0.13.0";
    sources = {
      x86_64-linux.hash = "sha256-KofDeUyyp9AkKlHHaViDuL6uUafF+sWJp9WN3hlYs4U=";
      aarch64-linux.hash = "sha256-M/PSiiN76iBCA+8Fdvg1+s+n4QkQzlAohr+PW0NMu3s=";
    };
    iconHash = "sha256-kw3d/yQQFy7pZIb2q2J6vtRK1fTXYOHKuCR6TXTZTLo=";
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
    version = "0.27.1";
    owner = "tangency-labs";
    sources = {
      x86_64-linux.hash = "sha256-PHoRi7pdoDPfq22mOaSUdGrPYsdOc3DrqqffVnNGuQ8=";
      aarch64-linux.hash = "sha256-X6MgBiSGtrDfNH4/IEUaoxbZetFqOdECalRa2NEpfYs=";
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
