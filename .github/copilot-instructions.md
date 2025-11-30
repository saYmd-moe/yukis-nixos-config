# NixOS Configuration Copilot Instructions

## Project Structure & Architecture

-   **Core**: Flake-based NixOS configuration targeting `nixos-25.05`.
-   **Entry Point**: `flake.nix` defines inputs (`nixpkgs`, `home-manager`, `daeuniverse`) and the `yuki-desktop` system.
-   **System Config**: `hosts/yuki-desktop/default.nix` manages system-level settings (boot, networking, hardware, desktop environment).
-   **User Config**: `home/yuki/default.nix` manages user-level settings (VS Code, git, browsers) via Home Manager as a NixOS module.
-   **Overlays**: Located in `overlays/`, imported globally in `hosts/yuki-desktop/default.nix`.

## Critical Workflows

### Deployment Cycle

**NEVER** edit `/etc/nixos` directly. Always edit this repository.

1.  **Sync & Validate**: Run `./deploy.sh`.
    -   Performs a dry-run build (`nixos-rebuild build`) in a temp directory.
    -   Syncs files to `/etc/nixos` using `rsync` (excluding `.git`, `result`).
2.  **Apply**:
    ```bash
    sudo nixos-rebuild switch --flake .#yuki-desktop
    ```

### Package Management

-   **System-wide**: Add to `environment.systemPackages` in `hosts/yuki-desktop/default.nix`.
-   **User-specific**: Add to `home.packages` in `home/yuki/default.nix`.
-   **VS Code Extensions**: Managed declaratively in `home/yuki/default.nix` under `programs.vscode.profiles.default.extensions`.

## Project-Specific Conventions

-   **Proxy/Network**:
    -   Uses `daed` (with web dashboard) from `daeuniverse` flake input.
    -   Service defined in `hosts/yuki-desktop/default.nix` (`services.daed`).
    -   Firewall ports 12345 are opened for it.
-   **Hardware**:
    -   Includes specific support for RGB/Cooling: `openrgb`, `liquidctl`, `coolercontrol`.
    -   Windows drive mounted at `/mnt/windows` (NTFS).
-   **Formatting**: Use `nixfmt` (specifically `nixfmt-rfc-style`).
-   **Secrets**: Stored in `secrets/` (e.g., `secrets/dae/boostnet.txt`), read via `builtins.readFile`.

## Key File Locations

-   `flake.nix`: Inputs and outputs definition.
-   `hosts/yuki-desktop/default.nix`: Main system configuration.
-   `home/yuki/default.nix`: Main user configuration.
-   `deploy.sh`: Deployment script.
