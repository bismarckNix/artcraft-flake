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
#   configFile     config file name, defaults to preferences.json
#
#   categories     optional, the mimeapps categories (e.g. graphics, editor, etc.)
#   mimeTypes      optional, the mime types (e.g. image/png, video/mp4, etc.)
#   noSettings     optional, disables settings
#                  (should only be used for apps that don't have a settings format that doesn't work well with Nix, e. g. .ron)
{
  craft-launcher = rec {
    displayName = "Craft Launcher";
    description = "The Craft App Launcher";
    version = "0.4.0";
    asset = "artcraft-launcher-${version}-linux-x86_64.AppImage";
    hash = "sha256-bbHF6EUw2c36l1Tt5A1udXx5BN4Dhd7SqsvwkAW0cXA=";
    iconHash = "sha256-+Hr4G2+kEdqIIO7Sv9zFTA7pzUU7ToaMZPVsadsULQ4=";
    noSettings = true;
    launcher = true;   # This makes the app not be disabled by the launcherOnly option
  };

  photocraft = rec {
    displayName = "PhotoCraft";
    description = "An open-source, photo editor written by scratch in pure Rust";
    version = "0.8.2";
    hash = "sha256-XrZW3mhq9QTYFg1RmMLI1BTPi3qNPsxja8i6j7VkSKc=";
    iconHash = "sha256-vhncj2zRUF9u3XWe5+mRzWfrHVVaXLqzcZnmwSv8Hkg=";
  };

  vectorcraft = rec {
    displayName = "VectorCraft";
    description = "An open-source, vector art tool written by scratch in pure Rust";
    version = "0.10.0";
    hash = "sha256-LS2JWHAURlwwlqbkVtc6c7tq7BBOwO0hOkBqFIAmwCk=";
    iconHash = "sha256-fBaE9J6W/zSXDx0RqOYb7RQuHvKv69NPo8mSOcAG2VI=";
    configFile = "ui.json";
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.7.2";
    hash = "sha256-q/kg2Y0BWGDh9brcbPBQfY+BFvXDKPf38kJfBoqzrug=";
    iconHash = "sha256-265KioOCW8Xtc/UmfdMpqj7bq2BSGt+jl0rQw7/3VHQ=";
    configPath = ".local/share";
  };

  lightcraft = {
    displayName = "LightCraft";
    description = "An open-source non-destructive photo editor written by scratch in pure Rust";
    version = "0.7.1";
    hash = "sha256-eAeHlKa9jxAmA28lA6HPcWrSw7V+HKiyvcRkcgmcHkg=";
    iconHash = "sha256-EnhY5ZQgcEbHvppl0cQgu80VIujAaP7NwxAI+SPcnG0=";
    configFile = "ui.json";
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
    configFile = "prefs.json";
  };

  designcraft = {
    displayName = "DesignCraft";
    description = "An open-source page and layout design editor written by scratch in pure Rust";
    version = "0.7.1";
    hash = "sha256-T7tdLSwvHWf7fhMeVKhUUxDEiSWMpaLVUJp6LF0/pZs=";
    iconHash = "sha256-wlS3YBxzDMCwoC+0S7rWgeSdyJ8vhKztDH6pxNTmHLw=";
    designcraft = "prefs.json";
  };
}
