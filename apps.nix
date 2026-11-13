# ArtCraft app entries. If you want to add an app, add an entry here.
#
# Fields:
#   displayName    XDG desktop entry name
#   genericName    XDG desktop entry generic name (short description)
#   comment        XDG desktop entry comment
#
#   version        release version (no leading "v")
#   owner          the owner of the repository, defaults to storytold
#   tag            release tag (default "v${version}")
#   assetPrefix    AppImage file name
#                  (default "${name}-${version}-linux-x86_64.AppImage")
#
#   sources:
#   ${source}.hash fixed-output hash of the AppImage/icon; null = fake hash
#   icon.url       XDG desktop entry icon url, deafults to
#                  https://raw.githubusercontent.com/storytold/${name}/main/assets/app-icon/${name}.svg,
#                  removes the app icon if set to null
#
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
  anicraft = {
    displayName = "AniCraft";
    genericName = "Animation Studio";
    comment = "Draw and animate 2D vector art on a timeline";
    version = "0.2.1";
    sources = {
      x86_64-linux.hash = "sha256-NSRWOE0egvNz2DbcvNnxRzsWA8XJx7GF12MhhHAJGzE=";
      aarch64-linux.hash = "sha256-IY7FSdMBojUkFjhY3GC7FYRWI3TnWvVeefVI8Uconf8=";
      icon.hash = "sha256-jMSU1Y5ZJ8hgAbcNkU49d8yLu5bfT7nGAGv/t7aqzSE=";
    };
    noSettings = true;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "application/x-anicraft" "application/x-fla" "application/x-xfl" ];
  };

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
    version = "0.20.1";
    sources = {
      x86_64-linux.hash = "sha256-56XSRFAP5FzKv6hcYywl7NofsDeZwxjZrVQfZbFQ548=";
      aarch64-linux.hash = "sha256-nHJbnYpNKwm60GF1xRy7pPlbcYtscMPeNfqkoAfkqSE=";
      icon = {
        url = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
        hash = "sha256-99cPBgscUQDnZvQbthaOPqyOtwwhkUxYQM1NiRAFI0E=";
      };
    };
    noSettings = true;
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
    version = "0.6.1";
    sources = {
      x86_64-linux.hash = "sha256-fq3eHXSrQsyDiGL+P4MePPPJ+mul4r8E4oJLvEcUYTQ=";
      aarch64-linux.hash = "sha256-4amB8/8vInDLUM7s4PNhQttdjP5hHVPnFfFAprhwg/0=";
      icon.hash = "sha256-jETFj6K7n0av3+oE/hXgmCDbMldIqPh8jD+Y3mZ+dGs=";
    };
    noSettings = true;
    categories = [ "Development" "Debugger" ];
  };

  craft-launcher = rec {
    displayName = "Craft Launcher";
    genericName = "App Launcher";
    comment = "Install, update and launch the Craft App Suite";
    version = "0.19.2";
    assetPrefix = "artcraft-launcher";
    sources = {
      x86_64-linux.hash = "sha256-AhgImRbWC00oiCXRVC8Tyyyl+2kUGPQQIgH0OoTRvns=";
      aarch64-linux.hash = "sha256-2inZCuTWiDk2/IDI+DlXH/EuFF09eYpKXmH7yhrTPsg=";
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
    version = "0.18.1";
    sources = {
      x86_64-linux.hash = "sha256-aN+fBA0/bEzkqQSq3sYzlh+hmSSPChqjZvpkWXrgmGc=";
      aarch64-linux.hash = "sha256-iUyx3HlGkY/+bwzc4y2eIVfRSfrqZzdjgWQIPV5WJhU=";
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
    version = "0.20.1";
    sources = {
      x86_64-linux.hash = "sha256-+db9a7GkIYUCQ8DUvkQjVxOp7Fsm+L8dW6h6/Pj5FTQ=";
      aarch64-linux.hash = "sha256-FOZBLMixVjNXHAsJhpuJ8j6irGGz5oGbOyYoTpK2hpM=";
      icon.hash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    };
    categories = [ "Graphics" "Publishing" ];
  };

  effectcraft = {
    displayName = "EffectCraft";
    genericName = "Motion Graphics Editor";
    comment = "Motion graphics and visual effects compositor";
    version = "0.24.1";
    sources = {
      x86_64-linux.hash = "sha256-n4oWz3QUfJ4qw7ZfpvW+lqPhDq2S3fCNVE9dOZCtZNw=";
      aarch64-linux.hash = "sha256-iYmPo0buXFmzgV8k2zGBeMojpLWTdpvdhA2oH3L00G8=";
      icon.hash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    };
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  figcraft = {
    displayName = "FigCraft";
    genericName = "Interface Design Tool";
    comment = "Design and prototype user interfaces";
    version = "0.18.1";
    sources = {
      x86_64-linux.hash = "sha256-lYaULdYxuWtMVSKYjp6AITkHuAIv+vvKYko/wRrnqek=";
      aarch64-linux.hash = "sha256-j92ff58OOP3venydMEmEUWd/SBo44dGEsYpd+FeZ7fc=";
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
    version = "0.20.1";
    sources = {
      x86_64-linux.hash = "sha256-SiWuyy6UgbZec1NSi8qeSoxTiN1V8Uhv/mRQLgi9+gI=";
      aarch64-linux.hash = "sha256-SHwXUCgShd5n9odS4RVDMrCJk8la7itCceQWTsPDM2U=";
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
    version = "0.19.1";
    sources = {
      x86_64-linux.hash = "sha256-WxzhCtbHotOJJJ39JZAQAUqF/OGqQsYn/EzaVxZx4iE=";
      aarch64-linux.hash = "sha256-8v/Msp0LfDcFP8e9Br/79OKQfLLfLk9ZPPHf0FHgvV4=";
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
    version = "0.21.1";
    sources = {
      x86_64-linux.hash = "sha256-xCEtoid3oAANnrZshbeGXp6ZEfR6YCB9eFK3wGOtqKk=";
      aarch64-linux.hash = "sha256-tEaBa6prxBUB6ecFxudXqFm8EDpjSK7BPoOMs3bcbiI=";
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

  mailcraft = {
    displayName = "MailCraft";
    genericName = "Mail Client";
    comment = "Read and write mail, keep a calendar, contacts and tasks";
    version = "0.12.0";
    owner = "UCS-Care-Group";
    sources = {
      x86_64-linux.hash = "sha256-BWTvCD/xI37KaCNQNN8Ju8PubrtYaf/lCdLL0J5T7FE=";
      aarch64-linux.hash = "sha256-GduI/hp9tD+HL29UDJhR/GXKAqB5I4P8QwrvSAk+Zyo=";
      icon = {
        url = "https://raw.githubusercontent.com/UCS-Care-Group/mailcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/io.github.billsecond.mailcraft.svg";
        hash = "sha256-sVP+1DXNXMXvpAhAiXe23rVJb0ryF/4ALD36efS5bFM=";
      };
    };
    prefsFile = null;
    categories = [ "Office" "Email" "Calendar" "ContactManagement" ];
    mimeType = [
      "message/rfc822" "application/mbox" "text/calendar"
      "text/vcard" "x-scheme-handler/mailto"
    ];
  };

  materialcraft = {
    displayName = "MaterialCraft";
    genericName = "Procedural Material Designer";
    comment = "Design procedural PBR materials with node graphs";
    version = "0.4.1";
    sources = {
      x86_64-linux.hash = "sha256-1R++QDSoIgR0UHIi9k2AHiZknIEzs+e0WPPpdYwItqE=";
      aarch64-linux.hash = "sha256-qBdguCuhGGZaWQE/tJVJxLmFFHgzdSDA7m7++EKS+ZQ=";
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
    version = "0.21.1";
    sources = {
      x86_64-linux.hash = "sha256-cwJ2zamt2z1I8mxgJobRj8W8Dr42CmCi9SLXDP1CjSE=";
      aarch64-linux.hash = "sha256-40oTbx+aP+q9taTqj4+6G7PlrFTzliSQ5+BB/c9Y318=";
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
    version = "0.23.1";
    sources = {
      x86_64-linux.hash = "sha256-BXR7PlJ+HgoMHeOZcDYc84yPyn6NPjYB7yCC+w5t0X8=";
      aarch64-linux.hash = "sha256-5D1N675mzw6idiYJfydWhIF2pVQKPeWSUshd08dpgkY=";
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
    version = "0.41.0";
    owner = "tangency-labs";
    sources = {
      x86_64-linux.hash = "sha256-xFs5DeRDiHTZ033xcqEq+KVWJB6+POGdgL5cIB31xs4=";
      aarch64-linux.hash = "sha256-Pd9+ycEvsUU1JT0yAqH6sE0svYVHZSzvXwBCMi9XDrU=";
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
    version = "0.20.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-TbtAKkE+wqUxA7n6d9Y1bm/usIbZSXXJXmNcdLQ02vg=";
      aarch64-linux.hash = "sha256-fa0KtRV7aeQ8DFQmZf1jxVcKbCihNexw8afw77zb5QM=";
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
    version = "0.6.1";
    sources = {
      x86_64-linux.hash = "sha256-kEdgAW/TdL8J/RtKPIQBy8fmvDy8DUQn43S5v4ExbKY=";
      aarch64-linux.hash = "sha256-MDzMTMR9uMT3KhwVeNnC99VziiskM+fUbkelgn+VHX8=";
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
    version = "0.24.1";
    sources = {
      x86_64-linux.hash = "sha256-vc5+gumB+fTtC/JfpvJeb+T6sn6JZB5vlIiZ4BsTpRQ=";
      aarch64-linux.hash = "sha256-SbccWfjZmiiO6p6db1Ar3HLEjcizr9VNAEExAtuiWeE=";
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
    version = "0.18.1";
    sources = {
      x86_64-linux.hash = "sha256-u8XBWwbUQDz9WllHW9+SZKScK88fktEjMRtQqdzjyIg=";
      aarch64-linux.hash = "sha256-EemhHA3JJMKiYSB9jPRe4jKTC/BpJTOi6YQjf2geBzw=";
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
