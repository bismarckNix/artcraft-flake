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
  cadcraft = {
    displayName = "CADCraft";
    genericName = "Computer-Aided Design";
    comment = "Draft, dimension and plot 2D drawings; open DXF and DWG files";
    version = "0.17.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
    sources = {
      x86_64-linux.hash = "sha256-I+XPzjIcitvMVtuB/6LkftnfpESRjbuqo2LWeBAPnlk=";
      aarch64-linux.hash = "sha256-LFiv7b5O4abNKM7DKG2K+0BGW1cH6o8TvIfIZRxvCnk=";
    };
    iconHash = "sha256-99cPBgscUQDnZvQbthaOPqyOtwwhkUxYQM1NiRAFI0E=";
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
    version = "0.3.0";
    sources = {
      x86_64-linux.hash = "sha256-uSz0YGGN6fKXWUxlkjhGkPqZ/Enhk6RMIAhVGCLw5SI=";
      aarch64-linux.hash = "sha256-SJXGpP00dEppXZAMMQg7wHGWIAH0NoX0Ca9W5sTP2yw=";
    };
    noSettings = true;
    iconHash = "sha256-jETFj6K7n0av3+oE/hXgmCDbMldIqPh8jD+Y3mZ+dGs=";
    categories = [ "Development" "Debugger" ];
  };

  craft-launcher = rec {
    displayName = "Craft Launcher";
    genericName = "App Launcher";
    comment = "Install, update and launch the Craft App Suite";
    version = "0.14.1";
    assetPrefix = "artcraft-launcher";
    iconUrl = "https://raw.githubusercontent.com/storytold/craft-launcher/refs/heads/main/assets/app-icon/artcraft-launcher.svg";
    sources = {
      x86_64-linux.hash = "sha256-QsHOhWQ5GbyH2qPiRB0DuQ8AShaCo18luVy7mOXwdds=";
      aarch64-linux.hash = "sha256-FdVEtmfjcLsCXMx77SeCDa2G3c+f0jnqQ0/0e+gkPks=";
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

  deckcraft = {
    displayName = "DeckCraft";
    genericName = "Presentation";
    comment = "Create and present slide decks";
    version = "0.15.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/deckcraft/refs/heads/main/assets/app-icon/hicolor/scalable/apps/ai.storyteller.deckcraft.svg";
    sources = {
      x86_64-linux.hash = "sha256-+VV9FTGJWXg5pFYTPc+XJyuqwVIDGHH60K7DttZWB4U=";
      aarch64-linux.hash = "sha256-2OsjEJytTEI/NFuOUDYx5lvo741aju9enruhaX+hOl4=";
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

  designcraft = {
    displayName = "DesignCraft";
    genericName = "Page Layout";
    comment = "Lay out magazines, books and print documents";
    version = "0.17.2";
    sources = {
      x86_64-linux.hash = "sha256-MOnSpasyK+5HmAAQq2ihaBBh2alwDqmJoz2lTwg5cw8=";
      aarch64-linux.hash = "sha256-7deMW+6d7OvcUzi66JY3uVj/XjDbzLg88mkF7J146mY=";
    };
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    categories = [ "Graphics" "Publishing" ];
  };

  effectcraft = {
    displayName = "EffectCraft";
    genericName = "Motion Graphics Editor";
    comment = "Motion graphics and visual effects compositor";
    version = "0.21.1";
    sources = {
      x86_64-linux.hash = "sha256-W9VdQHYJugst9IPjqVUFQiOY0rh0MV2lBr6x9NWVjzw=";
      aarch64-linux.hash = "sha256-PX4yarrxpi6iw9XubxHLumWnYbZbxIgO39HOzxCc/1I=";
    };
    iconHash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    uiFile = null;
    categories = [ "AudioVideo" "Video" "Graphics" "2DGraphics" ];
  };

  figcraft = {
    displayName = "FigCraft";
    genericName = "Interface Design Tool";
    comment = "Design and prototype user interfaces";
    version = "0.15.1";
    sources = {
      x86_64-linux.hash = "sha256-9wvCPup0rNp1kC4VxkJqQ21mRKCDQOU9S2N4dCefW4c=";
      aarch64-linux.hash = "sha256-TQatdbwYUyyi/XFzVhrjEkE4Td6u8RfScptTdOC43g0=";
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

  filmcraft = rec {
    displayName = "FilmCraft";
    genericName = "Video Editor";
    comment = "Edit video, color and sound";
    version = "0.17.1";
    sources = {
      x86_64-linux.hash = "sha256-D1JJdbxUyRd6yAbby5y+HZ97+xifpfbLSfVnIkY3fi8=";
      aarch64-linux.hash = "sha256-Lh3j53MgPiDBH6qv1n9ZDARHFUUVREPlwMQXadSmtF8=";
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

  gridcraft = {
    displayName = "GridCraft";
    genericName = "Spreadsheet";
    comment = "Calculate, analyse and chart data in workbooks";
    version = "0.16.1";
    sources = {
      x86_64-linux.hash = "sha256-l7atP75HHS3pTeqqfbMSYko53WPl7h679rOFY9Yqrlc=";
      aarch64-linux.hash = "sha256-OyQci6YIwDVSeAWAIFLtADUDrRFQFmjLfCgkrWGdN6I=";
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

  lightcraft = {
    displayName = "LightCraft";
    genericName = "Photo Library and Raw Developer";
    comment = "Organise photos and develop raw files, non-destructively";
    version = "0.18.1";
    sources = {
      x86_64-linux.hash = "sha256-NGz4TCYjIpNLSou+6fvX2zjxWRfJPy3QQJeS0Rv6fbA=";
      aarch64-linux.hash = "sha256-UqfG5Dq+9DTs/Zdamjt/gYLMNh2bbqGCYw5Wbcu0qL4=";
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

  materialcraft = {
    displayName = "MaterialCraft";
    genericName = "Procedural Material Designer";
    comment = "Design procedural PBR materials with node graphs";
    version = "0.1.2";
    sources = {
      x86_64-linux.hash = "sha256-dA5Oz+wm06eUdcijgZSxIPv7xbPtenebEfukddx2MsM=";
      aarch64-linux.hash = "sha256-yjMcVidy0tr0cJpnS+LKjY5Tqnfn7a/z3JztfHHgj4o=";
    };
    iconHash = "sha256-vY4FZhlwkacfE4HVdu7l/VhVtoMqBsbikUQNEqG3EQ0=";
    noSettings = true;
    categories = [ "Graphics" "3DGraphics" ];
    mimeType = [ "application/x-materialcraft" ];
  };

  pdfcraft = {
    displayName = "PdfCraft";
    genericName = "PDF Editor";
    comment = "Read, organize, combine, split and secure PDFs";
    version = "0.18.2";
    sources = {
      x86_64-linux.hash = "sha256-vtsfgXPn65+h1YALZbQe07Wletk+VmHGqSGipFAkIpE=";
      aarch64-linux.hash = "sha256-/UhGvpREK4ao5j+5fJmxNrNJKPvyrLbF7PmrMHmCy/I=";
    };
    iconHash = "sha256-J3RcAhgw+CwDOw8V8tjZ+OCZE4dDKXiH/34snn7Qado=";
    noSettings = true;     # .ron configuration
    categories = [ "Office" "Viewer" ];
    mimeType = [ "application/pdf" ];
    };

  photocraft = rec {
    displayName = "PhotoCraft";
    genericName = "Image Editor";
    comment = "Edit photos and layered PSD documents";
    version = "0.20.2";
    sources = {
      x86_64-linux.hash = "sha256-vhjRdaCmJ4wwEkJBeTu3ezV++WBG2B8dgYnkksFLwK4=";
      aarch64-linux.hash = "sha256-jymLOaZ9j+UZqZqnUtoBeGLI40bzoTUgVHj9XbW9cDo=";
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

  solidcraft = {
    displayName = "SolidCraft";
    genericName = "3D CAD";
    comment = "Parametric 3D CAD: sketch, constrain, extrude, and change a parameter to rebuild";
    version = "0.30.1";
    owner = "tangency-labs";
    sources = {
      x86_64-linux.hash = "sha256-HODWGv04IA8MFieTGgSF8DuD4KiLHHTHXhoVAek4g10=";
      aarch64-linux.hash = "sha256-fsI4eicQUWyoRiXLAGY1n9BpOEmQYUe8p8yLMQG3hVM=";
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

  soundcraft = {
    displayName = "SoundCraft";
    genericName = "Digital Audio Workstation";
    comment = "Record, edit and mix audio and MIDI";
    version = "0.17.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    sources = {
      x86_64-linux.hash = "sha256-hRg4ou2zv3ssoS4cVGDR5rTDa77yBQrwN32W5MJxiJw=";
      aarch64-linux.hash = "sha256-0WOwbPhp+4OUcdhhuWfEZIal8MxYjhK/1WWIH2iAIAM=";
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

  texturecraft = {
    displayName = "TextureCraft";
    genericName = "3D texture painter";
    comment = "Paint PBR textures directly on 3D meshes";
    version = "0.3.2";
    sources = {
      x86_64-linux.hash = "sha256-gNdpsvpgrXU0iLDDfFIM5DH1TUL3U7JAcaCT0xkh5bk=";
      aarch64-linux.hash = "sha256-F1qgkqQ+17vVnd80Oak0HBO6wE9FqwAjwYndvbdxSlk=";
    };
    iconHash = "sha256-GbloLuQs+vsG5oH+sgiDfrC50/oHcIzjppUSuUXBawA=";
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
    version = "0.21.1";
    sources = {
      x86_64-linux.hash = "sha256-eGVCmEYRl3Lb1d2TlcuojHGQz/W5KxexQRA65yhcmeA=";
      aarch64-linux.hash = "sha256-Qsmq+VeEVKWkLuoah0bDsqFQGTxR3pzxsS58KJ5pO+I=";
    };
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    prefsFile = null;
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
    mimeType = [ "image/svg+xml" "application/pdf" ];
  };

  wordcraft = {
    displayName = "WordCraft";
    genericName = "Word Processor";
    comment = "Write and design documents; open and save Word files";
    version = "0.15.2";
    sources = {
      x86_64-linux.hash = "sha256-dJMrxn/l9TVTBah7eertnlq4NvaF4WM69JkhYeR/gKQ=";
      aarch64-linux.hash = "sha256-ddzfA1+PUzxRZdnlLMmaCQmOo6T+XvOPOz5Kdko3rPI=";
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
}
