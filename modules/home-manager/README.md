# modules/home-manager/

可重用的 Home Manager 模块位于此处（例如 `vscode.nix`、`shells.nix`）。

在 `home/*/default.nix` 中导入它们，或通过 `home-manager.extraSpecialArgs` 从 `flake.nix` 公开它们。
