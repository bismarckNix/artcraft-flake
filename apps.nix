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
    version = "0.7.0";
    assetPrefix = "artcraft-launcher";
    iconUrl = "https://raw.githubusercontent.com/storytold/craft-launcher/refs/heads/main/assets/app-icon/artcraft-launcher.svg";
    sources = {
      x86_64-linux.hash = "sha256-+Aub3P65K8iKVNB+fy4D8YgPP88lwVEYZLPUEY7O4dg=";
      aarch64-linux.hash = "sha256-gvuGpMB4yN7j4WfeLspwTheKi48NgnOqtXz37eD6abQ=";
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
    version = "0.15.1";
    sources = {
      x86_64-linux.hash = "sha256-fZbz0NoZIdY0YgsNTNo3y/M1OnZ/kguQbOHGZnOA/+0=";
      aarch64-linux.hash = "sha256-GlanyK/nif3n4GKoHqxq2NORrLKX10TTVAG3mibWuTE=";
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
    version = "0.16.0";
    sources = {
      x86_64-linux.hash = "sha256-ih8iRY0rAJQO/RpWneziWEj60Yx1pad9XoxLcZKpIxk=";
      aarch64-linux.hash = "sha256-vVqN1wlO7pXKZxE8vC/a+5T02gCB4a+ymgx7XqeI4BQ=";
    };
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "image/svg+xml" "application/pdf" ];
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.12.0";
    sources = {
      x86_64-linux.hash = "sha256-EJM/kXaDWAVFm7YNy4ECOSsGVGfsoRDbfuFbVaEcnpY=";
      aarch64-linux.hash = "sha256-pewsB7Kkm5YWvr5U5O6RzvN7SiSWOiy3I/kVgqws6rs=";
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
    version = "0.13.0";
    sources = {
      x86_64-linux.hash = "sha256-B+8MY5vSEcHLolLmgDlTwdmUYvVbVh0wv5vXrEpOfXs=";
      aarch64-linux.hash = "sha256-RvEpkzcRGPQVjEsZ/28B4f/cLPgEm+ot2eNvgYUzM4I=";
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
    version = "0.13.0";
    sources = {
      x86_64-linux.hash = "sha256-P8ZO1lHbJiuZT82cw9XXuy5NR5mktKGzh5Ldtf4QbGA=";
      aarch64-linux.hash = "sha256-1g4Q8bnVPs+8enzcXFjKvAaMtcba2KjomcOjHBPwkw4=";
    };
    iconHash = "sha256-UrOEoQoqf90xRdmCKXLP1WjvDLcxJUm9Q5mt3YnUWm0=";
    noSettings = true;     # Unfortunetly, this currently uses .ron format,  which isn't compatible with Nix
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
    };

  effectcraft = {
    displayName = "EffectCraft";
    description = "An open-source motion graphics and compositing tool written by scratch in pure Rust";
    version = "0.16.0";
    sources = {
      x86_64-linux.hash = "sha256-k6bJjkp1VSxOXxHgxoNNO2+KZxjBZwqDSfY35u7OoLw=";
      aarch64-linux.hash = "sha256-0QvAYl91b+NbwAUJB59qlqWOL9sY26NEVk+C0+ezpmU=";
    };
    iconHash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  designcraft = {
    displayName = "DesignCraft";
    description = "An open-source page and layout design editor written by scratch in pure Rust";
    version = "0.12.0";
    sources = {
      x86_64-linux.hash = "sha256-fXbEP5ABfh6DmCFVvQV4ZEh/TGisfMZXMTNNkO9R7Zo=";
      aarch64-linux.hash = "sha256-fWOKmPlqKtpifAw+jUdc5Hq91EH0jsj8mDQgL8Nyovs=";
    };
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    categories = [ "Graphics" "Publishing" ];
  };

  figcraft = {
    displayName = "FigCraft";
    description = "An open-source, clean-room reimplementation of collaborative design workflows in pure Rust";
    version = "0.10.0";
    sources = {
      x86_64-linux.hash = "sha256-KPjv4Yd5SY4obOk+lEIFjw2xe0Vw4suSv1JsPnI0hOk=";
      aarch64-linux.hash = "sha256-0rRBc8iJLgCTW/4hVpe9CEa3DM4gHghBj4stuEz8Jns=";
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
    version = "0.10.0";
    sources = {
      x86_64-linux.hash = "sha256-Lrjqr2vpiaRvWhJShqmfXC9u+lyLsjulCkQju+oQeiA=";
      aarch64-linux.hash = "sha256-L23YeAGbVpQl8ykhpNZCEQFyYQuPBlw0XCvwuBCTvls=";
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
    version = "0.12.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-phpWaR+tXCKUS0QyKlt9ttcX5b9Hrfjcu8iD9UmFk+s=";
      aarch64-linux.hash = "sha256-H43XCJDajh6nMOgXJBBcGzfPbOwhox1cu17iPddkoJA=";
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
    version = "0.10.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/deckcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/ai.storyteller.deckcraft.svg";
    sources = {
      x86_64-linux.hash = "sha256-Ds31nBP3ZSDnvH9jgb6lyKytfXWvfzkLh0imb9XObGk=";
      aarch64-linux.hash = "sha256-3xTHQMFAnBy3z19lNAAnZ1fpt+16xif+BQ8YkHUJ3AQ=";
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
    version = "0.12.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
    sources = {
      x86_64-linux.hash = "sha256-6FFLtojQPPpg32VK3FcGpEJbBGA26HPGheDdL6R+m3M=";
      aarch64-linux.hash = "sha256-hCH6kORgLjR2GwHM6ZOooAnRAu1DKKtzMmhZ//covvc=";
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
    version = "0.11.1";
    sources = {
      x86_64-linux.hash = "sha256-XrNEOP3fJCcdYwnR9LhtB7uNSSYUM9kLiP0k5CMwxiU=";
      aarch64-linux.hash = "sha256-sDLgPlx5lrAdBF49k+MSF6mRv2sxLTRApU57A/Y1tD0=";
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
}
