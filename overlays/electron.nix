# Imported by: overlays/default.nix
self: super:
let
  # 辅助函数：安全地为包添加 Wayland 参数
  # pkg: 目标包
  # binaryName: 可执行文件名 (如果为 null，则尝试使用 pname)
  addWaylandFlags =
    pkg: binaryName:
    pkg.overrideAttrs (old: {
      # 1. 确保 makeWrapper 存在于构建依赖中
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ self.makeWrapper ];

      postInstall = (old.postInstall or "") + ''
        # 2. 确定二进制文件名：优先使用传入的名称，否则回退到 pname
        target_bin="${if binaryName != null then binaryName else old.pname}"

        # 3. 检查文件是否存在，防止构建失败
        if [[ -f "$out/bin/$target_bin" ]]; then
          echo "Wrapping $target_bin with Wayland flags..."
          wrapProgram "$out/bin/$target_bin" \
            --add-flags "--ozone-platform=wayland" \
            --add-flags "--enable-features=WaylandWindowDecorations" \
            --add-flags "--password-store=gnome-libsecret"
        else
          echo "Warning: $out/bin/$target_bin not found. Skipping Wayland wrapper."
        fi
      '';
    });
in
{
  # 自动覆盖 Electron 基础包 (通常二进制名就是 electron)
  electron = addWaylandFlags super.electron null;
  electron_25 = addWaylandFlags super.electron_25 null;
  electron_27 = addWaylandFlags super.electron_27 null;

  # 手动适配应用，指定准确的二进制名称
  microsoft-edge = addWaylandFlags super.microsoft-edge "microsoft-edge";

  # QQ 的二进制名通常是 qq，但也可能是 linuxqq，视具体包而定
  # 这里保留两个覆盖以防万一，或者你可以检查一下你的 qq 包具体叫什么
  qq = addWaylandFlags super.qq "qq";
  linuxqq = addWaylandFlags super.linuxqq "linuxqq";
}
