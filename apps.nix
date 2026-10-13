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
#   asset          optional, AppImage file name
#                  (default "${name}-${version}-linux-x86_64.AppImage")
#   extraPkgs      optional, p: [ p.somelib ]  extra libs inside the FHS wrapper
#   configPath     config path relative to $XDG_CONFIG_HOME, default to ~/.config/${name}
#   prefsFile      config file name, defaults to prefs.json
#   uiFile         ui file name, defaults to ui.json; null = disabled
#
#   categories     optional, the mimeapps categories (e.g. graphics, editor, etc.)
#   mimeTypes      optional, the mime types (e.g. image/png, video/mp4, etc.)
#   noSettings     optional, disables settings
#                  (should only be used for apps that don't have a settings format that doesn't work well with Nix, e. g. .ron)
{
  craft-launcher = rec {
    displayName = "Craft Launcher";
    description = "The Craft App Launcher";
    version = "0.4.1";
    asset = "artcraft-launcher-${version}-linux-x86_64.AppImage";
    hash = "sha256-bbHF6EUw2c36l1Tt5A1udXx5BN4Dhd7SqsvwkAW0cXA=";
    iconHash = "sha256-+Hr4G2+kEdqIIO7Sv9zFTA7pzUU7ToaMZPVsadsULQ4=";
    noSettings = true;
    launcher = true;   # This makes the app desktop entry not be disabled by the launcherOnly option
    categories = [ "Utility" "Graphics" "AudioVideo" "Office" ];
  };

  photocraft = rec {
    displayName = "PhotoCraft";
    description = "An open-source, photo editor written by scratch in pure Rust";
    version = "0.8.2";
    hash = "sha256-XrZW3mhq9QTYFg1RmMLI1BTPi3qNPsxja8i6j7VkSKc=";
    iconHash = "sha256-vhncj2zRUF9u3XWe5+mRzWfrHVVaXLqzcZnmwSv8Hkg=";
    prefsFile = "preferences.json";
    uiFile = null;
    categories = [ "Graphics" "2DGraphics" "RasterGraphics" "Photography" ];
    mimeTypes = [
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
    version = "0.10.0";
    hash = "sha256-LS2JWHAURlwwlqbkVtc6c7tq7BBOwO0hOkBqFIAmwCk=";
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOAG2VI=";
    categories = [ "Graphics" "2DGraphics" "VectorGraphics" ];
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.7.2";
    hash = "sha256-q/kg2Y0BWGDh9brcbPBQfY+BFvXDKPf38kJfBoqzrug=";
    iconHash = "sha256-265KioOCW8Xtc/UmfdMpqj7bq2BSGt+jl0rQw7/3VHQ=";
    configPath = ".local/share";
    prefsFile = "preferences.json";
    uiFile = null;
  };

  lightcraft = {
    displayName = "LightCraft";
    description = "An open-source non-destructive photo editor written by scratch in pure Rust";
    version = "0.7.1";
    hash = "sha256-eAeHlKa9jxAmA28lA6HPcWrSw7V+HKiyvcRkcgmcHkg=";
    iconHash = "sha256-EnhY5ZQgcEbHvppl0cQgu80VIujAaP7NwxAI+SPcnG0=";
    prefsFile = null;
  };

  pdfcraft = {
    displayName = "PdfCraft";
    description = "An open-source PDF reader and editor written by scratch in pure Rust";
    version = "0.7.1";
    hash = "sha256-rlyHm7Mm0OkaJB6fnGwXYI73ZsAFxmwtcoAnAQe/Y1o=";
    iconHash = "sha256-UrOEoQoqf90xRdmCKXLP1WjvDLcxJUm9Q5mt3YnUWm0=";
    noSettings = true;     # Unfortunatly, this currently uses .ron format,
    };                     # which isn't compatable with Nix

  effectcraft = {
    displayName = "EffectCraft";
    description = "An open-source motion graphics and compositing tool written by scratch in pure Rust";
    version = "0.9.2";
    hash = "sha256-9e8cKtMgUepsE7E8FwpzvW8tCoOaT/cYlbFqkNOjrjc=";
    iconHash = "sha256-zHI82IlPI0bs4oGqsZLeM8uSpELdZGa5V/wNvFOd8/A=";
    uiFile = null;
  };

  designcraft = {
    displayName = "DesignCraft";
    description = "An open-source page and layout design editor written by scratch in pure Rust";
    version = "0.7.1";
    hash = "sha256-T7tdLSwvHWf7fhMeVKhUUxDEiSWMpaLVUJp6LF0/pZs=";
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
  };

  wordcraft = {
    displayName = "WordCraft";
    description = "An open-source, clean-room reimplementation of Microsoft Word in pure Rust";
    version = "0.6.1";
    hash = "sha256-Nu04RMTlg5HPE0HRM79rVptSIfjnB+Xicds8ON9tw8M=";
    iconHash = "sha256-mmjLf30R335QARJdO9f60vXMTc2x32YAbLz66IfmG0Y=";
    prefsFile = null;
    categories = [ "Office" "WordProcessor" ];
    mimeTypes = [
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
    version = "0.6.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/deckcraft/main/assets/app-icon/deckcraft-1024.png";
    hash = "sha256-ghZQ0/h6chIwbzO4t7Bc8Z0TOQoxNZ7zt0o8M88Y7SE=";
    iconHash = "sha256-RXywRqGk8uE/Bs9+LgcctI9gEWM+1im5n/NIvkypHOA=";
  };

  gridcraft = {
    displayName = "GridCraft";
    description = "An open-source, clean-room spreadsheet (Microsoft Excel-style) in pure Rust";
    version = "0.6.1";
    hash = "sha256-nbcvSahW9DmlyJs+tP0+1RxKepluvmaS5Y0ej12jyVQ=";
    iconHash = "sha256-kw3d/yQQFy7pZIb2q2J6vtRK1fTXYOHKuCR6TXTZTLo=";
  };

  cadcraft = {
    displayName = "CADCraft";
    description = "An open-source, clean-room AutoCAD-style app in pure Rust";
    version = "0.6.2";
    iconUrl = "https://raw.githubusercontent.com/storytold/cadcraft/main/assets/app-icon/cadcraft-256.png";
    hash = "sha256-MtqtoRubblEucqoHHOvzyvF/dBuF8JR0m/85rTYDatE=";
    iconHash = "sha256-99cPBgscUQDnZvQbthaOPqyOtwwhkUxYQM1NiRAFI0E=";
    noSettings = true;   # Same story as PdfCraft - the config is in .ron format
  };

  soundcraft = {
    displayName = "SoundCraft";
    description = "An open-source, clean-room reimplementation of Avid Pro Tools in pure Rust";
    version = "0.6.1";
    iconUrl = "https://raw.githubusercontent.com/storytold/soundcraft/refs/heads/main/assets/app-icon/icon.svg";
    hash = "sha256-aMZY8uctdKMnf0jfPOE+TbnG6v1/FCX2Pi3IXYZ5EgA=";
    iconHash = "sha256-NNwZQivzPcVyOezsAYBL9uoIUTiTF75v6bINEhduPBI=";
    prefsFile = null;
  };
}
