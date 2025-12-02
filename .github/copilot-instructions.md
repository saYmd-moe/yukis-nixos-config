# NixOS Configuration Copilot Instructions

## Project Structure & Architecture

-   **Core**: Flake-based NixOS configuration targeting `nixos-25.11`.
-   **Entry Point**: `flake.nix` defines inputs (`nixpkgs`, `home-manager`, `daeuniverse`) and the `yuki-desktop` system.
-   **System Config**: `hosts/yuki-desktop/default.nix` is the main entry, importing shared config from `hosts/default.nix`.
-   **User Config**: `home/yuki/default.nix` manages user settings via Home Manager, integrated as a NixOS module.
-   **Modules**: Organized in `modules/nixos` (system) and `modules/home-manager` (user). Imported explicitly in host/home configs.
-   **Custom Packages**: Defined in `pkgs/`, exposed via overlay as `my-pkgs` (e.g., `my-pkgs.cider3`).

## Critical Workflows

### Deployment Cycle

**NEVER** edit `/etc/nixos` directly. Always edit this repository.

1.  **Sync & Validate**: Run `./deploy.sh`.
    -   Performs a dry-run build (`nixos-rebuild build`) in a temp directory.
    -   Syncs files to `/etc/nixos` using `rsync` (excluding `.git`, `result`).
2.  **Apply**:
    ```bash
    # After syncing to /etc/nixos
    sudo nixos-rebuild switch
    # OR apply directly from current directory (for testing)
    sudo nixos-rebuild switch --flake .#yuki-desktop
    ```

### Package Management

-   **System-wide**: Add to `environment.systemPackages` in `hosts/yuki-desktop/default.nix` or `hosts/default.nix`.
-   **User-specific**: Add to `home.packages` in `home/yuki/default.nix`.
-   **Custom Pkgs**: Use `my-pkgs.<name>` (e.g., `my-pkgs.cider3`). Defined in `pkgs/<name>/package.nix`.
-   **VS Code**: Managed declaratively in `modules/home-manager/programs/vscode.nix` or `home/yuki/default.nix`.

## Project-Specific Conventions

-   **Module Imports**: Prefer explicit relative imports for local modules (e.g., `../../modules/nixos/desktop/kde.nix`).
-   **Proxy/Network**:
    -   Uses `daed` (daeuniverse) defined in `modules/nixos/services/daed.nix`.
    -   Service enabled in `hosts/yuki-desktop/default.nix`.
-   **Hardware**:
    -   Windows drive mounted at `/mnt/windows` (NTFS).
    -   Specific hardware modules in `modules/nixos/hardware/`.
-   **Formatting**: Use `nixfmt-rfc-style`.
-   **Secrets**: Stored in `secrets/`, read via `builtins.readFile`.

## Key File Locations

-   `flake.nix`: Inputs/Outputs.
-   `hosts/yuki-desktop/default.nix`: Host-specific system config.
-   `hosts/default.nix`: Shared system config (locale, core pkgs).
-   `home/yuki/default.nix`: User config.
-   `overlays/default.nix`: Overlay entry point (includes `my-pkgs`).
