# ArtCraft app entries. If you want to add an app, add an entry here.
#
# Fields:
#   displayName    shown in launchers
#   iconUrl        launcher icon
#   description    package description
#   version        release version (no leading "v")
#   hash/iconHash  fixed-output hash of the AppImage/icon; null = fake hash
#   tag            optional, release tag (default "v${version}")
#   asset          optional, AppImage file name
#                  (default "${name}-${version}-linux-x86_64.AppImage")
#   extraPkgs      optional, p: [ p.somelib ]  extra libs inside the FHS wrapper
#   configFile     optional, config path relative to $XDG_CONFIG_HOME
#
#   categories     optional, the mimeapps categories (e.g. graphics, editor, etc.)
#   mimeTypes      optional, the mime types (e.g. image/png, video/mp4, etc.)
{
  craft-launcher = rec {
    displayName = "Craft Launcher";
    iconUrl = "https://raw.githubusercontent.com/storytold/craft-launcher/main/assets/app-icon/artcraft-launcher.svg";
    description = "The Craft App Launcher";
    version = "0.3.2";
    asset = "artcraft-launcher-${version}-linux-x86_64.AppImage";
    hash = "sha256-ftxw2jW/IUoiFSh5SLj9piCz3+VQdq7Fbo12vhpoqLU=";
    iconHash = "sha256-+Hr4G2+kEdqIIO7Sv9zFTA7pzUU7ToaMZPVsadsULQ4=";
  };
  photocraft = rec {
    displayName = "PhotoCraft";
    iconUrl = "https://raw.githubusercontent.com/storytold/photocraft/main/assets/app-icon/photocraft-small.svg";
    description = "An open-source, photo editor written by scratch in pure Rust";
    version = "0.7.0";
    hash = "sha256-h+vONrzfazHRapyiLOKfmtjbaBheTZgRiADRwt54rEI=";
    iconHash = "sha256-vhncj2zRUF9u3XWe5+mRzWfrHVVaXLqzcZnmwSv8Hkg=";
  };

  filmcraft = rec {
    displayName = "FilmCraft";
    iconUrl = "https://raw.githubusercontent.com/storytold/filmcraft/main/assets/app-icon/filmcraft-small.svg";
    description = "An open-source, nonlinear video editor written by scratch in pure Rust";
    version = "0.6.0";
    hash = "sha256-wLWl0PDnEXaqgGyJX4ylE/LVBbcP74W4dLviPJEjK8c=";
    iconHash = "sha256-265KioOCW8Xtc/UmfdMpqj7bq2BSGt+jl0rQw7/3VHQ=";
    configFile = ".local/share";
  };
}
