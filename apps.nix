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
#   tag            optional, release tag (default "v${version}")
#   assetPrefix    optional, AppImage file name
#                  (default "${name}-${version}-linux-x86_64.AppImage")
#   extraPkgs      optional, p: [ p.somelib ]  extra libs inside the FHS wrapper
#   configName     optional, config directory name, defaults to the ${name}
#   configPath     optional, config path relative to $XDG_CONFIG_HOME, default to ~/.config/${name}
#   prefsFile      config file name, defaults to prefs.json; null - disabled
#   uiFile         ui file name, defaults to ui.json; null = disabled
#
#   categories     optional, the mimeapps categories (e.g. graphics, editor, etc.)
#   mimeType       optional, the mimeType (e.g. image/png, video/mp4, etc.)
#   startupWMClass optional, the app ID
#   noSettings     optional, disables settings
#                  (should only be used for apps that don't have a settings format that doesn't work well with Nix, e. g. .ron)
{
  craft-launcher = rec {
    displayName = "Craft Launcher";
    description = "The Craft App Launcher";
    version = "0.5.1";
    assetPrefix = "artcraft-launcher";
    iconUrl = "https://raw.githubusercontent.com/storytold/craft-launcher/refs/heads/main/assets/app-icon/artcraft-launcher.svg";
    sources = {
      x86_64-linux.hash = "sha256-1CmJcpVdHtbF/XdZ/dLk3EvFIbPQQM97SJG3hweDH3M=";
      aarch64-linux.hash = "sha256-RdlfvRTrNGLRogzJuZ4Nof+zOVH+pWhEWEu3nFiCeNI=";
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
    version = "0.10.0";
    sources = {
      x86_64-linux.hash = "sha256-zRozyXnopdqU3tgddkjnecuAabd+Ssp0PI0XfKUnDXc=";
      aarch64-linux.hash = "sha256-gC3pl76z+pvDh2KbSZ6CcEtIr4OayF8lU+qcKyAihF8=";
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
    version = "0.13.1";
    sources = {
      x86_64-linux.hash = "sha256-lUV7ubSLxjRBJMK/MqEGAGVIqllLG40djKR9UqMOV34=";
      aarch64-linux.hash = "sha256-xc+sH2fWJiwPWZsgc5huRdHg1LRQe3L2deMwj2N7Agw=";
    };
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "image/svg+xml" "application/pdf" ];
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.9.0";
    sources = {
      x86_64-linux.hash = "sha256-eE5M29iYLxe07IHK9TZ/0wjXChI6eqdLzNdCAhTAxEc=";
      aarch64-linux.hash = "sha256-DBIodVa0rsTIn/x+ZYFkEbkWBsyKPpZC5q05UFEDbO0=";
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
    version = "0.9.1";
    sources = {
      x86_64-linux.hash = "sha256-vQAoUalSQ0nJ2JIq4rhcmMJX3hZIDTt/iFgBo7ZLbRg=";
      aarch64-linux.hash = "sha256-8jbCufcDvLDxx+7xmNNsiXCIZlnuLWIpWLdrw9QJFR8=";
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
    version = "0.9.0";
    sources = {
      x86_64-linux.hash = "sha256-+FaMh5BtloRhBS8LVwl8C4S3Cze/ZJybUE2MHretDPo=";
      aarch64-linux.hash = "sha256-6vBd0cRYziB+nZn8116KPgyXE2wl++fpClC4bHZ7O7s=";
    };
    iconHash = "sha256-UrOEoQoqf90xRdmCKXLP1WjvDLcxJUm9Q5mt3YnUWm0=";
    noSettings = true;     # Unfortunetly, this currently uses .ron format,  which isn't compatible with Nix
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
    };

  effectcraft = {
    displayName = "EffectCraft";
    description = "An open-source motion graphics and compositing tool written by scratch in pure Rust";
    version = "0.11.1";
    sources = {
      x86_64-linux.hash = "sha256-Ix5g82czTX6FiR/mU8SkNKoJPCExPh7Mj+FFm2/Vg3k=";
      aarch64-linux.hash = "sha256-FPhp96K9OKtC/+3KcAYiZDJtHecKFvOa8a5ZiRGkLgk=";
    };
    iconHash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  designcraft = {
    displayName = "DesignCraft";
    description = "An open-source page and layout design editor written by scratch in pure Rust";
    version = "0.9.0";
    sources = {
      x86_64-linux.hash = "sha256-5atgOZuSMnEjWUARiRjW8MRgowgqCQsPb+TZ0EkNqbU=";
      aarch64-linux.hash = "sha256-VN13euVOK22TDckChGXwvs6aWKkEuenOUbi5VAfuUq0=";
    };
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    categories = [ "Graphics" "Publishing" ];
  };

  wordcraft = {
    displayName = "WordCraft";
    description = "An open-source, clean-room reimplementation of Microsoft Word in pure Rust";
    version = "0.8.0";
    sources = {
      x86_64-linux.hash = "sha256-ffezpQFyug7ehaLEuDw2CvkrHDdnyLMMOWPr8F02q5w=";
      aarch64-linux.hash = "sha256-osaVoGTI2hO9AOEYJYusXN+pt+bcfY89/dh/VhKY52o=";
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

  deckcraft = {
    displayName = "DeckCraft";
    description = "An open-source, clean-room reimplementation of Microsoft PowerPoint in pure Rust";
    version = "0.8.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/deckcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/ai.storyteller.deckcraft.svg";
    sources = {
      x86_64-linux.hash = "sha256-XCTgw9UscQIZ+2uJfL8uhW4PbdTcebeizvwdLVUTTtA=";
      aarch64-linux.hash = "sha256-o/9JjKrDu+inIpfe1j2UzY94MVoP+vMLavdxfOLfn9I=";
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

  gridcraft = {
    displayName = "GridCraft";
    description = "An open-source, clean-room spreadsheet (Microsoft Excel-style) in pure Rust";
    version = "0.8.0";
    sources = {
      x86_64-linux.hash = "sha256-lCCWoppTSqJQPp56oYFulS9yUOc9VfjzKv0HdUdhf3c=";
      aarch64-linux.hash = "sha256-+0WCb1KaFgf7hASl970wIuSPx3jZNr0oT/QqhZ+bB5U=";
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

  cadcraft = {
    displayName = "CADCraft";
    description = "An open-source, clean-room AutoCAD-style app in pure Rust";
    version = "0.8.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
    sources = {
      x86_64-linux.hash = "sha256-JPd+NyvwcjP3JnJFi8aRNdVLyfa7Y3ntc3hwp8EVK9I=";
      aarch64-linux.hash = "sha256-oZgrRhGwu7gLjpxTYCORiQ1jglmuo8IDlKGXyssM9lQ=";
    };
    iconHash = "sha256-99cPBgscUQDnZvQbthaOPqyOtwwhkUxYQM1NiRAFI0E=";
    noSettings = true;   # Same story as PdfCraft - the config is in .ron format
    categories = [ "Graphics" "Engineering" "VectorGraphics" ];
    mimeType = [
      "image/vnd.dxf" "image/vnd.dwg"
      "application/x-dxf" "application/acad"
    ];
  };

  soundcraft = {
    displayName = "SoundCraft";
    description = "An open-source, clean-room reimplementation of Avid Pro Tools in pure Rust";
    version = "0.8.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-nDj40aXIGPZzoX9oqVLqiXLOpKtHIFkL2345NQSGZ2g=";
      aarch64-linux.hash = "sha256-Rz+i+9nOKkfB0b3EKyCPTO0k6NtqjPU0YH3X2EUbNE8=";
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
  figcraft = {
    displayName = "FigCraft";
    description = "An open-source, clean-room reimplementation of collaborative design workflows in pure Rust";
    version = "0.7.0";
    sources = {
      x86_64-linux.hash = "sha256-M+JvmVLm9m6QclbFZhmo9168KmH8PHj8M5ba4hC9PIU=";
      aarch64-linux.hash = "sha256-pKlIG8N5gLVCJn+HvQZkDStBmQSYK15l68CDDjgsy6Q=";
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
}
