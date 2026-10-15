# **ArtCraft Creative Suite**

This flake provides the ArtCraft creative suite for NixOS,
it is reproducible and can be configured [declaratively](#configuration),
without overwriting the options you configured with your GUI.

## **Installation**

1. Add this to your `flake.nix` inputs:

```nix
artcraft = {
  url = "github:bismarckNix/artcraft-flake";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

1. Import the module:

* For NixOS (global, only GUI configuration):

```nix
# configuration.nix
imports = [ inputs.artcraft.nixosModules.default ]
```

* For home manager (user-only, declarative and GUI configuration, **recommended**):

```nix
# home.nix
imports = [ inputs.artcraft.homeModules.default ]
```

> [!NOTE]
>
> `inputs.artcraft.<module>.default` imports all of the modules at once.
> You can import only a single module with `inputs.artcraft.<module>.<app>`
>
> e.g `inputs.artcraft.homeModules.photocraft` will only import
> PhotoCraft to your home manager.

1. Enable it:

```nix
programs.artcraft.<app>.enable = true
```

> [!TIP]
> You can enable every app using ``programs.artcraft.fullSuite.enable = true``

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

## **Configuration**

> [!WARNING]
> Not all apps can be configured via Nix,
> some of them have their configuration files in `*.ron` format,
> which can't be merged with the configuration using `jq`,
> and does not have an official Nix converter, unlike `json`.

### Shared (NixOS and home-manager)

* `package = ...` - The package to install.

* `extraArgs = [ ... ]` - Extra command-line arguments passed on every launch.

* `environment = [ ... ]` - Environment variables set for the app.

* `xwayland = true/false` - Run under XWayland. Needed for drag and drop on Wayland,
requires an XWayland server to be available.

* `desktopEntry = true/false` - Enable/disable desktop entry for app.

* `launcherOnly = true/false` - Disable all desktop entries except for Craft Launcher.

### Home Manager

* `settings = { ... }` - controls prefs.json

* `uiSettings = { ... }` - controls ui.json

#### Example

```nix
# home.nix
{
  programs.artcraft = {
    fullSuite.enable = true;
    launcherOnly = true;

    photocraft = {
      xwayland = true;
      environment = [ --some-flag ];
      extraArgs = {
        WGPU_BACKEND = "vulkan";
      };
      settings = {
        interface.appearanceMode = "dark";
      };
    };
  }
}
```

## **Available Apps and Configuration File Locations**

> [!NOTE]
> To configure the files declaratively, configure them using the GUI first,
> then, look at the configuration file location listed below
> and search for the option you configured.

| **App** | **Configurable Files** | **Configuration Option** |
| ---------------------- | ------------------------------------------------- | ---------------------- |
| **Craft Launcher** | *None* (.ron file format, unconfigurable via Nix) | *None* |
| **PhotoCraft** | `~/.config/photocraft/preferences.json` | settings   = { ... } |
| **VectorCraft** | `~/.config/vectorcraft/ui.json` | uiSettings = { ... } |
| **FilmCraft** | `~/.local/share/filmcraft/preferences.json` | settings   = { ... } |
| **LightCraft** | `~/.config/vectorcraft/ui.json` | uiSettings = { ... } |
| **PdfCraft** | *None* (.ron format) | *None* |
| **EffectCraft** | `~/.config/effectcraft/prefs.json` | settings   = { ... } |
| **DesignCraft** | `~/.config/designcraft/prefs.json` | settings   = { ... } |
| | `~/.config/designcraft/ui.json` | uiSettings = { ... } |
| **WordCraft** | `~/.config/wordcraft/ui.json` | uiSettings = { ... } |
| **DeckCraft** | `~/.config/deckcraft/prefs.json` | settings   = { ... } |
| | `~/.config/deckcraft/ui.json` | uiSettings = { ... } |
| **GridCraft** | `~/.config/gridcraft/prefs.json` | settings   = { ... } |
| | `~/.config/gridcraft/ui.json` | uiSettings = { ... } |
| **CADCraft** | *None* (.ron format) | *None* |
| **SoundCraft** | `~/.config/soundcraft/ui.json` | uiSettings = { ... } |
| **FigCraft** | `~/.config/FigCraft/state.json` | settings   = { ... } |

<details>
<summary><strong>Configuration Option Example</strong></summary>
  Converting PhotoCraft dark mode into Nix:

  ```json
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
