# Imported by: pkgs/default.nix
{
  lib,
  appimageTools,
  requireFile,
}:

let
  pname = "Cider";
  version = "3.1.8"; # 根据实际情况修改版本号

  # 使用 requireFile 方法
  # 这种方法更加优雅，因为它不需要将大文件放入 git 仓库，也不依赖本地特定路径。
  #
  # 使用步骤:
  # 1. 获取 AppImage 文件的 SHA256 哈希值:
  #    sha256sum path/to/cider-v3.1.8-linux-x64.AppImage
  #    或者
  #    nix hash file path/to/cider-v3.1.8-linux-x64.AppImage
  #
  # 2. 将哈希值填入下方的 sha256 字段。
  #
  # 3. 将文件添加到 Nix Store (每次构建前如果 Store 中没有都需要执行，或者文件变动后):
  #    nix-store --add-fixed sha256 path/to/cider-v3.1.8-linux-x64.AppImage
  #
  src = requireFile {
    name = "cider-v3.1.8-linux-x64.AppImage";
    url = "https://cider.sh";
    # 替换为实际文件的 SHA256 哈希值
    sha256 = "sha256-s1CMYAfDULaEyO0jZguA2bA7D7ogqRR4v/LkMD+luKw=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    # 安装 Desktop 文件
    # 尝试查找 desktop 文件
    if [ -f ${appimageContents}/cider.desktop ]; then
      install -m 444 -D ${appimageContents}/cider.desktop $out/share/applications/${pname}.desktop
    elif [ -f ${appimageContents}/Cider.desktop ]; then
      install -m 444 -D ${appimageContents}/Cider.desktop $out/share/applications/${pname}.desktop
    else
      # 宽泛查找
      find ${appimageContents} -name "*.desktop" -exec install -m 444 -D {} $out/share/applications/${pname}.desktop \;
    fi

    # 安装图标
    install -m 444 -D ${appimageContents}/cider.png \
      $out/share/icons/hicolor/512x512/apps/${pname}.png || true
      
    # 修复 Desktop 文件中的 Exec
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}' \
      --replace 'Exec=cider' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "Cider 3 - A new look into listening to music";
    homepage = "https://cider.sh";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "Cider";
  };
}
