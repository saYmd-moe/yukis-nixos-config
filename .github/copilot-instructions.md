# NixOS Configuration Copilot Instructions

## Project Context

This repository manages the NixOS configuration for the `yuki-desktop` system using **Nix Flakes** and **Home Manager**. The system targets the `nixos-25.05` channel.

## Architecture & File Structure

-   **Entry Point**: `flake.nix`
    -   Defines inputs: `nixpkgs`, `home-manager`, `daeuniverse`, `catppuccin`.
    -   Outputs `nixosConfigurations.yuki-desktop`.
    -   Integrates Home Manager as a NixOS module (`home-manager.nixosModules.home-manager`).
-   **System Configuration**: `hosts/yuki-desktop/default.nix`
    -   Defines system-level services (Boot, Network, Audio, Desktop).
    -   Imports `hardware-configuration.nix` (located in the same directory).
    -   Imports overlays from `overlays/`.
-   **User Configuration**: `home/yuki/default.nix`
    -   Managed via Home Manager module within `flake.nix`.
    -   Handles user packages (VS Code, Browsers, Chat apps).
    -   Receives flake inputs via `home-manager.extraSpecialArgs`.
-   **Modules & Overlays**:
    -   `overlays/`: Contains nixpkgs overlays (e.g., `librime.nix`).
    -   `modules/`: Reusable NixOS (`modules/nixos`) and Home Manager (`modules/home-manager`) modules.
    -   `pkgs/`: Custom package definitions.

## Critical Workflows

-   **Apply Configuration**:
    1.  Sync configuration to `/etc/nixos` (validates build first):
        ```bash
        ./deploy.sh
        ```
    2.  Apply the configuration:
        ```bash
        sudo nixos-rebuild switch --flake .#yuki-desktop
        ```
-   **Update Flake Inputs**:
    ```bash
    nix flake update
    ```
-   **Format Code**:
    Use `nixfmt` (specifically `nixfmt-rfc-style` is installed):
    ```bash
    nixfmt .
    ```

## Coding Conventions & Patterns

-   **Package Management**:
    -   Prefer `with pkgs; [ ... ]` for concise package lists.
    -   VS Code extensions are managed declaratively in `home/yuki/default.nix` under `programs.vscode.profiles.default.extensions`.
-   **Overlays**:
    -   Define overlays in separate files under `overlays/` (e.g., `overlays/librime.nix`).
    -   Import them in `hosts/<host>/default.nix` or `flake.nix` rather than defining them inline.
-   **Hardware & Services**:
    -   **Proxy**: Uses `daed` service from `daeuniverse` input.
    -   **Desktop**: KDE Plasma 6 (`services.desktopManager.plasma6`).
    -   **Audio**: PipeWire enabled, PulseAudio disabled.
    -   **Input Method**: Fcitx5 + Rime (customized via overlay).

## Integration Details

-   **Home Manager**:
    -   Configured with `useGlobalPkgs = true` and `useUserPackages = true`.
    -   User `yuki` configuration is imported directly in `flake.nix`.
-   **External Flakes**:
    -   `daeuniverse`: Provides `daed` module.
    -   `catppuccin`: Provides theming modules.
