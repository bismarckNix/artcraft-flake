# **ArtCraft Creative Suite**

This flake provides the [ArtCraft creative suite](https://github.com/storytold) for NixOS.
It is reproducible and can be configured [declaratively](#configuration),
without overwriting the options you configured with your GUI,
unless you declare it.

The packages are shipped as wrapped AppImages and support
*x86-64-linux* and *aarch64-linux*.

## Try it

> [!TIP]
> You can try out the apps with
> `nix run github:bismarckNix/artcraft-flake#<app>`, e.g.:

```shell
nix run github:bismarckNix/artcraft-flake#photocraft
```

You can view all the available apps [here](#applist)

## **Installation**

1. Add this to your `flake.nix` inputs:

    > ```nix
    > artcraft = {
    >   url = "github:bismarckNix/artcraft-flake";
    >   inputs.nixpkgs.follows = "nixpkgs";
    >   };
    > ```

2. Import the module:

    * For NixOS (global, only GUI configuration):

    > ```nix
    > # configuration.nix
    > imports = [ inputs.artcraft.nixosModules.default ];
    > ```

    * For home manager (user-only, declarative and GUI configuration, **recommended**):

    > ```nix
    > # home.nix
    > imports = [ inputs.artcraft.homeModules.default ];
    > ```

> [!NOTE]
> `inputs.artcraft.<module>.default` imports all of the modules at once.
> You can import only a single module with `inputs.artcraft.<module>.<app>`
>
> e.g `inputs.artcraft.homeModules.photocraft` will only import
> PhotoCraft to your home manager.

1. Enable it:

    > ```nix
    > programs.artcraft.<app>.enable = true;
    > ```

> [!TIP]
> You can enable every app using ``programs.artcraft.fullSuite.enable = true;``

<details>
<summary><strong>Home Manager Module</strong></summary>
Add this to your home manager:

  ```nix
  # home.nix
  { inputs, ... }: {
    imports = [ inputs.artcraft.homeModules.default ];

    programs.artcraft = {
      fullSuite.enable = true;   # Enable all of the apps

      photocraft = {
        xwayland = true;         # Enable XWayland for drag and drop support
        settings = {
          interface.appearanceMode = "dark";
          # ...
          # Your other settings
        };
      };

      # ...
      # Other apps that you wish to configure
    };
  }
  ```

</details>

<details>
<summary><strong>NixOS Module</strong></summary>
  Add this to your configuration.nix:

  ```nix
  # configuration.nix
  { inputs, ... }: {
    imports = [ inputs.artcraft.nixosModules.default ];

    programs.artcraft = {
      fullSuite.enable = true;   # Enable all of the apps

      photocraft = {
        xwayland = true;         # Enable XWayland for drag and drop support
      };
    };
  }
  ```

</details>

<a name="configuration"></a>

> [!NOTE]
> If you don't want to declare the programs, you can only enable the launcher -
> it is able to install all of the apps and update them without the flake,
> so you will have faster updates (the packages won't depend on this repository
> anymore, except for the launcher), but no declarative features.

## **Configuration**

> [!WARNING]
> Not all apps can be configured via Nix,
> some of them have their configuration files in `*.ron` format,
> which can't be merged with the configuration using `jq`,
> and does not have an official Nix converter, unlike `json`.

### Shared (NixOS and home-manager)

* `package = ...` - The package to install. Defaults to this flake's package for
  the current system. Must provide `bin/<app>`, e.g. a different revision of
  this flake (see the example below).

* `extraArgs = [ ... ]` - Extra command-line arguments passed on every launch.

* `environment = [ ... ]` - Environment variables set for the app.

* `xwayland = true/false` - Run under XWayland. Needed for drag and drop on Wayland,
requires an XWayland server to be available, e.g. xwayland-satellite.

* `desktopEntry = true/false` - Enable/disable desktop entry for app.

* `launcherOnly = true/false` - Disable all desktop entries except for Craft Launcher.

> [!CAUTION]
> launcherOnly is a global setting, not per-app.
> It is enabled with `programs.artcraft.launcherOnly = true;`

### Home Manager

* `settings = { ... }` - controls prefs.json

* `uiSettings = { ... }` - controls ui.json

#### Example

```nix
# flake.nix
inputs = {
  artcraft.url = "github:bismarckNix/artcraft-flake";
  # Same flake, pinned to an older revision
  artcraft-old.url = "github:bismarckNix/artcraft-flake/<commit-or-tag>";
};
```

```nix
# home.nix (or configuration.nix)
{ inputs, pkgs, ... }: {
  programs.artcraft = {
    fullSuite.enable = true;
    launcherOnly = true;

    photocraft = {
      package = inputs.artcraft-old.packages.${pkgs.stdenv.hostPlatform.system}.photocraft;
      xwayland = true;
      extraArgs = [ --some-flag ];
      environment = {
        WGPU_BACKEND = "vulkan";
      };
    };
  };
}
```

<a name="applist"></a>

## **Available Apps, their names and Configuration File Locations**

> [!IMPORTANT]
> To configure the files declaratively, configure them using the GUI first,
> then, look at the configuration file location listed below
> and search for the option you configured.

| **App** | **Name** | **Configurable Files** | **Configuration Option** |
| - | - | - | - |
| [**Craft Launcher**](https://github.com/storytold/craft-launcher) | craft-launcher | *None* (.ron file format, unconfigurable via Nix) | *None* |
| [**PhotoCraft**](https://github.com/storytold/photocraft) | photocraft | `~/.config/photocraft/preferences.json` | settings   = { ... } |
| [**VectorCraft**](https://github.com/storytold/vectorcraft) | vectorcraft | `~/.config/vectorcraft/ui.json` | uiSettings = { ... } |
| [**FilmCraft**](https://github.com/storytold/filmcraft) | filmcraft | `~/.local/share/filmcraft/preferences.json` | settings   = { ... } |
| [**LightCraft**](https://github.com/storytold/lightcraft) | lightcraft | `~/.config/lightcraft/ui.json` | uiSettings = { ... } |
| [**PdfCraft**](https://github.com/storytold/pdfcraft) | pdfcraft | *None* (.ron format) | *None* |
| [**EffectCraft**](https://github.com/storytold/effectcraft) | effectcraft | `~/.config/effectcraft/prefs.json` | settings   = { ... } |
| [**DesignCraft**](https://github.com/storytold/designcraft) | designcraft | `~/.config/designcraft/prefs.json` | settings   = { ... } |
| | | `~/.config/designcraft/ui.json` | uiSettings = { ... } |
| [**WordCraft**](https://github.com/storytold/wordcraft) | wordcraft | `~/.config/wordcraft/ui.json` | uiSettings = { ... } |
| [**DeckCraft**](https://github.com/storytold/deckcraft) | deckcraft | `~/.config/deckcraft/prefs.json` | settings   = { ... } |
| | | `~/.config/deckcraft/ui.json` | uiSettings = { ... } |
| [**GridCraft**](https://github.com/storytold/gridcraft) | gridcraft | `~/.config/gridcraft/prefs.json` | settings   = { ... } |
| | | `~/.config/gridcraft/ui.json` | uiSettings = { ... } |
| [**CADCraft**](https://github.com/storytold/cadcraft) | cadraft | *None* (.ron format) | *None* |
| [**SoundCraft**](https://github.com/storytold/soundcraft) | soundcraft | `~/.config/soundcraft/ui.json` | uiSettings = { ... } |
| [**FigCraft**](https://github.com/storytold/figcraft) | figcraft | `~/.config/FigCraft/state.json` | settings   = { ... } |

<details>
<summary><strong>Configuration Example</strong></summary>
  Converting PhotoCraft dark mode into Nix:

  ```jsonc
  // ~/.config/photocraft/preferences.json
  {
    // ...
    "interface": {
      "appearanceMode": "dark",
      // ...
    },
    // ...
  }
  ```

  ```nix
  # home.nix
  {
    # ...
    programs.artcraft.photocraft = {
      settings = {
        interface.appearanceMode = "dark";
      };
    };
    # ...
  }
  ```

</details>

## LICENSE

This project is licensed under the [MIT License](./LICENSE).
