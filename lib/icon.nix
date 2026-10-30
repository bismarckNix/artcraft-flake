# Fetches an app's launcher icon.
# Returns null when the app has no iconUrl.
# A missing or null iconHash becomes lib.fakeHash, so the build fails
# and prints the real hash ("got: sha256-...").
{
  lib,
  pkgs,
  name,
  app
}:
let
  owner = app.owner or "storytold";
  iconUrl =
    app.iconUrl or "https://raw.githubusercontent.com/${owner}/${name}/main/assets/app-icon/${name}.svg";
in
if iconUrl == null then
  null
else
  pkgs.fetchurl {
    url = iconUrl;
    hash = if (app.iconHash or null) == null then lib.fakeHash else app.iconHash;
    name = "${name}-icon.svg";
  }
