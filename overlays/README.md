# overlays/

用途：存储 nixpkgs overlay 文件或扩展/覆盖软件包的小型 overlay 目录。

此仓库目前在 `hosts/yuki-desktop/default.nix` 中定义了一个内联 overlay 来自定义 `librime`。如果您想将 overlays 移动到文件，请将它们放在此处并从 `flake.nix` 或 `hosts/*/default.nix` 引用它们。

示例 overlay 文件路径：

```
overlays/librime-overlay.nix
```

遵循 nixpkgs overlay 约定（`final: prev: { ... }`）。
