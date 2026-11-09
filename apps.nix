# ArtCraft app entries. If you want to add an app, add an entry here.
#
# Fields:
#   displayName    XDG desktop entry name
#   genericName    XDG desktop entry generic name (short description)
#   comment        XDG desktop entry comment
#   iconUrl        XDG desktop entry icon url, deafults to
#                  https://raw.githubusercontent.com/storytold/${name}/main/assets/app-icon/${name}.svg,
#                  removes the app icon if set to null
#
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
#   categories     the XDG desktop entry mimeapps categories (e.g. graphics, editor, etc.)
#   mimeType       the XDG desktop entry mimeType (e.g. image/png, video/mp4, etc.)

{
  artcraft = rec {
    displayName = "ArtCraft Studio";
    genericName = "AI image and video creation";
    comment = "${genericName}";
    version = "0.41.1";
    tag = "artcraft-v${version}";
    sources = {
      x86_64-linux.hash = "sha256-uzJle26B6OR9pEyk52SxrxTXfYaQskiiY6Ss0SGLfS0=";
      aarch64-linux.hash = "sha256-MaQHF1jOeYnGVI45doOar2AQvkFNChtcyakTU3u8iN4=";
      icon = {
        url = "https://raw.githubusercontent.com/storytold/artcraft/main/crates/desktop/artcraft/icons/128x128.png";
        hash = "sha256-UF9EbjWO6CxzhE5gVOVKfqRzSRLaXzphCbrHRCy6pVE=";
      };
    };
    extraPkgs = p: [
      p.alsa-lib
      p.zlib
      p.libgpg-error
    ];
    noSettings = true;
    categories = [ "Graphics" ];
  };

  cadcraft = {
    displayName = "CADCraft";
    genericName = "Computer-Aided Design";
    comment = "Draft, dimension and plot 2D drawings; open DXF and DWG files";
    version = "0.19.0";
    sources = {
      x86_64-linux.hash = "sha256-AZ0KSroVUPr5FiTo0686344n/uGZdXm1T5hfaTOVuvk=";
      aarch64-linux.hash = "sha256-jD2MN9ROn4FZifsfZk0G65pVgUujFtCs1sK+91464dY=";
      icon = {
        url = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
        hash = "sha256-99cPBgscUQDnZvQbthaOPqyOtwwhkUxYQM1NiRAFI0E=";
      };
    };
    noSettings = true;   # Config is in .ron format
    categories = [ "Graphics" "Engineering" "VectorGraphics" ];
    mimeType = [
      "image/vnd.dxf" "image/vnd.dwg"
      "application/x-dxf" "application/acad"
    ];
  };

  craft-anything = {
    displayName = "Craft Anything";
    genericName = "Software Explorer";
    comment = "Find out how any software works, then craft your own";
    version = "0.6.0";
    sources = {
      x86_64-linux.hash = "sha256-mswr764Dgd7p3OvSVbzcdZKxafTvR3nC4tQj8Xz2vzk=";
      aarch64-linux.hash = "sha256-7dsmLVbxNoJDyXIqSmIu03WbUFgY+O8rz9qnWLEhGFQ=";
      icon.hash = "sha256-jETFj6K7n0av3+oE/hXgmCDbMldIqPh8jD+Y3mZ+dGs=";
    };
    noSettings = true;
    categories = [ "Development" "Debugger" ];
  };

  craft-launcher = rec {
    displayName = "Craft Launcher";
    genericName = "App Launcher";
    comment = "Install, update and launch the Craft App Suite";
    version = "0.19.0";
    assetPrefix = "artcraft-launcher";
    sources = {
      x86_64-linux.hash = "sha256-ZBl4WNFV9EeuMj+QUBURbYSPE3VnXXMesI1XCPhyLps=";
      aarch64-linux.hash = "sha256-aosU4qr6u1KvD7xTe+Y+wYU8qIGe7WmEWIpnqOXIvIc=";
      icon = {
        url = "https://raw.githubusercontent.com/storytold/craft-launcher/refs/heads/main/assets/app-icon/artcraft-launcher.svg";
        hash = "sha256-+Hr4G2+kEdqIIO7Sv9zFTA7pzUU7ToaMZPVsadsULQ4=";
      };
    };
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

  deckcraft = {
    displayName = "DeckCraft";
    genericName = "Presentation";
    comment = "Create and present slide decks";
    version = "0.17.0";
    sources = {
      x86_64-linux.hash = "sha256-oD0vCRpUHDKxT09n3olynShpjcKT8fmmIvVBnWQ9pZc=";
      aarch64-linux.hash = "sha256-F4U8kEutIgh8910krBTu6Kl8so3JMhwlOLoXvLZlUVQ=";
      icon = {
        url = "https://raw.githubusercontent.com/storytold/deckcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/ai.storyteller.deckcraft.svg";
        hash = "sha256-I+7cR+FM6m9MxnJLE67D5mjk4Bd/bO4fBy9Cg4Xg5t0=";
      };
    };
    categories = [ "Office" "Presentation" ];
    mimeType = [
      "application/x-deckcraft"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/vnd.openxmlformats-officedocument.presentationml.template"
      "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
    ];
  };

  designcraft = {
    displayName = "DesignCraft";
    genericName = "Page Layout";
    comment = "Lay out magazines, books and print documents";
    version = "0.19.0";
    sources = {
      x86_64-linux.hash = "sha256-6CINfkF3kOFSjchNTbX7IpPdAyfmLuKfjKA/CSgB6aU=";
      aarch64-linux.hash = "sha256-eacBjC6hPude9Ibrp6sm616M2ofun5O+15dJqYrppUs=";
      icon.hash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    };
    categories = [ "Graphics" "Publishing" ];
  };

  effectcraft = {
    displayName = "EffectCraft";
    genericName = "Motion Graphics Editor";
    comment = "Motion graphics and visual effects compositor";
    version = "0.23.1";
    sources = {
      x86_64-linux.hash = "sha256-eQVIXX6RmZoMGey6RH0N/RHBO92xMr35zKZc2LYGcfs=";
      aarch64-linux.hash = "sha256-sRmKb51ezSip9bz5DOPulUSPDqfqrAeS7rO8rZoF1tw=";
      icon.hash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    };
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  figcraft = {
    displayName = "FigCraft";
    genericName = "Interface Design Tool";
    comment = "Design and prototype user interfaces";
    version = "0.17.0";
    sources = {
      x86_64-linux.hash = "sha256-p0nZ+AdMvS3H0EoW1HJiABolKDkfoVO9bFxOT4TI5BQ=";
      aarch64-linux.hash = "sha256-D028Zsdqwqqq2Oku9Fhvx5SF5UD99mOkuqBniI54cvc=";
      icon.hash = "sha256-YQw68ZTWoI/dqj8VaTfftQqwbJ/rZYYst+uxFEZaMkM=";
    };
    configName = "FigCraft";
    prefsFile = "state.json";
    uiFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" "X-Design" ];
    mimeType = [
      "application/x-figcraft" "image/svg+xml" "image/png"
      "image/jpeg" "x-scheme-handler/figcraft"
    ];
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    genericName = "Video Editor";
    comment = "Edit video, color and sound";
    version = "0.19.0";
    sources = {
      x86_64-linux.hash = "sha256-LwnP9pY7VbwhYBWAYK+N4iaw7I/CI6GYsQFFpY4jj+g=";
      aarch64-linux.hash = "sha256-h9AbySFmk+XOQUOpL3aPdLXhXbqBqGN7TJDPpGPt8cc=";
      icon.hash = "sha256-TvQVY5ZG4XNH+Z+0YiCmA9AkepjFVFu8gtLyUyX+a54=";
    };
    configPath = ".local/share";
    prefsFile = "preferences.json";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "AudioVideoEditing" ];
    mimeType = [ "application/x-filmcraft" "video/mp4" "video/x-m4v"
      "video/quicktime" "video/x-matroska" "video/webm" "video/vnd.avi"
      "video/x-msvideo" "application/mxf" "video/mp2t" "video/mpeg" "video/3gpp"
    ];
  };

  gridcraft = {
    displayName = "GridCraft";
    genericName = "Spreadsheet";
    comment = "Calculate, analyse and chart data in workbooks";
    version = "0.18.0";
    sources = {
      x86_64-linux.hash = "sha256-/eL5mCrHaQJlIctvcQ7Ja02RmxY0rWixWyub9iRnAgw=";
      aarch64-linux.hash = "sha256-/nfck4OydamwS+LgqBgJnv7OoEWPNyzVcVM9bOiNfVU=";
      icon.hash = "sha256-pMVfL1KJOzGYYrYQwAavg9qfCXpBErWpgri6lfQ9KFA=";
    };
    categories = [ "Office" "Spreadsheet" ];
    mimeType = [
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.ms-excel.sheet.macroEnabled.12"
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
      "application/vnd.oasis.opendocument.spreadsheet" "text/csv"
      "text/tab-separated-values"
    ];
  };

  lightcraft = {
    displayName = "LightCraft";
    genericName = "Photo Library and Raw Developer";
    comment = "Organise photos and develop raw files, non-destructively";
    version = "0.20.0";
    sources = {
      x86_64-linux.hash = "sha256-Zr4ekYXVb2AIbpp8AZBk3SONlVMcE8DhyDpSf863PhA=";
      aarch64-linux.hash = "sha256-gQ6ZVlpv0L1EFM1Hj+5Ladpd4vdkvE+skPTa7v8IH5s=";
      icon.hash = "sha256-EnhY5ZQgcEbHvppl0cQgu80VIujAaP7NwxAI+SPcnG0=";
    };
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "RasterGraphics" "Photography" ];
    mimeType = [
      "image/jpeg" "image/png" "image/tiff" "image/webp" "image/x-adobe-dng"
      "image/x-sony-arw" "image/x-canon-cr2" "image/x-canon-cr3"
      "image/x-nikon-nef" "image/x-fuji-raf" "image/x-olympus-orf"
      "image/x-panasonic-rw2" "image/x-panasonic-rw" "image/x-pentax-pef"
    ];
  };

  materialcraft = {
    displayName = "MaterialCraft";
    genericName = "Procedural Material Designer";
    comment = "Design procedural PBR materials with node graphs";
    version = "0.3.0";
    sources = {
      x86_64-linux.hash = "sha256-rKIn8H0AR7xi3tj83mPdzDwQUZYPWTwCkZTW6d1Kaz0=";
      aarch64-linux.hash = "sha256-riQksKvEdlZkJF1FAm04sXjsuHnQDtN+CPdUv5azVgM=";
      icon.hash = "sha256-vY4FZhlwkacfE4HVdu7l/VhVtoMqBsbikUQNEqG3EQ0=";
    };
    noSettings = true;
    categories = [ "Graphics" "3DGraphics" ];
    mimeType = [ "application/x-materialcraft" ];
  };

  pdfcraft = {
    displayName = "PdfCraft";
    genericName = "PDF Editor";
    comment = "Read, organize, combine, split and secure PDFs";
    version = "0.20.0";
    sources = {
      x86_64-linux.hash = "sha256-An5iKZuCNTYANz5sp0xEEhPvVAbnDSf38a734Fp4h40=";
      aarch64-linux.hash = "sha256-u9gKgL5fvufWAvO2TZJj2Kb/66apn0DtiCBP9rwWU8M=";
      icon.hash = "sha256-J3RcAhgw+CwDOw8V8tjZ+OCZE4dDKXiH/34snn7Qado=";
    };
    noSettings = true;     # .ron configuration
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
    };

  photocraft = rec {
    displayName = "PhotoCraft";
    genericName = "Image Editor";
    comment = "Edit photos and layered PSD documents";
    version = "0.22.0";
    sources = {
      x86_64-linux.hash = "sha256-zuk05sOMD/f4zX7gNpQSi+Bb4Tf8QwEYDi9xbn0qH58=";
      aarch64-linux.hash = "sha256-iXKIUVnuV1UH4C18PXhLoqZZij7SBGnXJYbIuaadZmM=";
      icon.hash = "sha256-pIMzt7eUtwFY2pOiYthPuC9fu/dELbYPI1oKaRNqHOI=";
    };
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

  solidcraft = {
    displayName = "SolidCraft";
    genericName = "3D CAD";
    comment = "Parametric 3D CAD: sketch, constrain, extrude, and change a parameter to rebuild";
    version = "0.30.1";
    owner = "tangency-labs";
    sources = {
      x86_64-linux.hash = "sha256-HODWGv04IA8MFieTGgSF8DuD4KiLHHTHXhoVAek4g10=";
      aarch64-linux.hash = "sha256-fsI4eicQUWyoRiXLAGY1n9BpOEmQYUe8p8yLMQG3hVM=";
      icon = {
        url = "https://raw.githubusercontent.com/tangency-labs/solidcraft/refs/heads/main/assets/icons/app/linux/exports/hicolor/256x256/apps/io.tangencylabs.solidcraft.png";
        hash = "sha256-caPkknIFcc9XL6pR2Gp/916dfeoJFhQrUd6DW/hXxa8=";
      };
    };
    noSettings = true;
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
    mimeType = [
      "application/x-solidcraft" "model/step"
      "model/iges" "model/stl" "model/3mf"
    ];
  };

  soundcraft = {
    displayName = "SoundCraft";
    genericName = "Digital Audio Workstation";
    comment = "Record, edit and mix audio and MIDI";
    version = "0.19.0";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-qt7XTk8TLAM6zBIjx3anTlmnUdyQiEG0wxVy44k5GY8=";
      aarch64-linux.hash = "sha256-wLXXy9FOYY5omD1SheLR96wMSsN8PCu8YpMAMeDbgyA=";
      icon = {
        url = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
        hash = "sha256-NNwZQivzPcVyOezsAYBL9uoIUTiTF75v6bINEhduPBI=";
      };
    };
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

  texturecraft = {
    displayName = "TextureCraft";
    genericName = "3D texture painter";
    comment = "Paint PBR textures directly on 3D meshes";
    version = "0.5.0";
    sources = {
      x86_64-linux.hash = "sha256-so8Kf2ldQfWAn6UbhYjXG5k388X1hi7GEJB9CW7lzQA=";
      aarch64-linux.hash = "sha256-RDibiOXCFagiq/apz0NXO/TFVDqglg4FMq8Twhcasy4=";
      icon.hash = "sha256-GbloLuQs+vsG5oH+sgiDfrC50/oHcIzjppUSuUXBawA=";
    };
    noSettings = true;
    categories = [ "Graphics" "3DGraphics" ];
    mimeType = [
      "application/x-texturecraft" "model/gltf-binary" "model/gltf+json"
      "model/x-fbx" "model/vnd.collada+xml" "model/x-usd" "model/vnd.usda"
      "model/vnd.usdz+zip" "model/x-alembic" "model/obj" "model/x-ply" "model/stl"
    ];
  };

  vectorcraft = rec {
    displayName = "VectorCraft";
    genericName = "Vector Graphics Editor";
    comment = "Draw and edit vector illustrations, SVG and PDF";
    version = "0.23.0";
    sources = {
      x86_64-linux.hash = "sha256-ihMPRI+o3/CiedzvylYin1cCyzQRIyY0NtWHxFviqOQ=";
      aarch64-linux.hash = "sha256-KuZWoYf0raoojG6/pv1/pm4A24pR5Xl/F18vL4FwHMc=";
      icon.hash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    };
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "image/svg+xml" "application/pdf" ];
  };

  wordcraft = {
    displayName = "WordCraft";
    genericName = "Word Processor";
    comment = "Write and design documents; open and save Word files";
    version = "0.17.0";
    sources = {
      x86_64-linux.hash = "sha256-YGs64zDHZ8+hkoA9uo63udKcZs3ynQyr3gg/F/Bq0Ws=";
      aarch64-linux.hash = "sha256-OwROhthBgKBaSItCJJMRqdHtg1GQwTxK8Rzq9Yec7fw=";
      icon.hash = "sha256-mmjLf30R335QARJdO9f60vXMTc2x32YAbLz66IfmG0Y=";
    };
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
}
