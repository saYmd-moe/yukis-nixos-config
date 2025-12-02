{
  lib,
  stdenv,
  dpkg,
  autoPatchelfHook,
  alsa-lib,
  at-spi2-core,
  libtool,
  libxkbcommon,
  nspr,
  mesa,
  libtiff,
  udev,
  gtk3,
  libsForQt5,
  xorg,
  cups,
  pango,
  libjpeg,
  gtk2,
  gdk-pixbuf,
  libpulseaudio,
  libbsd,
  libusb1,
  libmysqlclient,
  llvmPackages,
  dbus,
  gcc-unwrapped,
  freetype,
  makeWrapper,
  fetchurl,
  bzip2,
  # optional: a fonts derivation to include with the package
  chineseFonts ? null,
}:

# let in 定义局部变量
let
  pkgVersion = "12.1.2.23578";
  url = "https://pubwps-wps365-obs.wpscdn.cn/download/Linux/365edu/${pkgVersion}/wps-office_${pkgVersion}.AK.preload.sw.withsn_amd64.deb";
  hash = "sha256-5h+U5kHZrgLh0gXd/U3hUL9OmtHlTt5HH/Bt4nPmugI=";
in

stdenv.mkDerivation rec {
  pname = "wps365-edu";
  version = pkgVersion;

  src = fetchurl {
    inherit url;
    sha256 = hash;
  };

  unpackCmd = "dpkg -x $src .";
  sourceRoot = ".";

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    at-spi2-core
    libtool
    libjpeg
    libxkbcommon
    nspr
    mesa
    libtiff
    udev
    gtk3
    libsForQt5.qt5.qtbase
    xorg.libXdamage
    xorg.libXtst
    xorg.libXv
    gtk2
    gdk-pixbuf
    libpulseaudio
    xorg.libXScrnSaver
    xorg.libXxf86vm
    libbsd
    libusb1
    libmysqlclient
    llvmPackages.openmp
    dbus
    libsForQt5.fcitx5-qt
    bzip2
  ]
  ++ lib.optional (chineseFonts != null) chineseFonts;

  dontWrapQtApps = true;

  runtimeDependencies = map lib.getLib [
    cups
    pango
    freetype
    gcc-unwrapped.lib
  ];

  autoPatchelfIgnoreMissingDeps = [
    # distribution is missing libkappessframework.so
    "libkappessframework.so"
    # qt4 support is deprecated
    "libQtCore.so.4"
    "libQtNetwork.so.4"
    "libQtXml.so.4"
    # file manager integration. Not needed
    "libnautilus-extension.so.1"
    "libcaja-extension.so.1"
    "libpeony.so.3"
    # libuof.so is a exclusive library in WPS. No need to repatch it
    "libuof.so"
    # libmysqlclient.so.18 is an old version, not available in recent nixpkgs
    "libmysqlclient.so.18"
  ];

  installPhase = ''
        runHook preInstall
        prefix=$out/opt/kingsoft/wps-office
        mkdir -p $out
        cp -r opt $out
        cp -r usr/* $out
        for i in wps wpp et wpspdf; do
          substituteInPlace $out/bin/$i \
            --replace /opt/kingsoft/wps-office $prefix
        done
        for i in $out/share/applications/*;do
          substituteInPlace $i \
            --replace /usr/bin $out/bin
        done

    # 只保留 wps-office-prometheus.desktop
    find $out/share/applications -name "*.desktop" -not -name "wps-office-prometheus.desktop" -delete

    # 修改 wps-office-prometheus.desktop
    desktopFile="$out/share/applications/wps-office-prometheus.desktop"
    if [ -f "$desktopFile" ]; then
      # 1. 修改 Name 为 "WPS"（并移除本地化名称以强制显示 "WPS"）
      sed -i 's/^Name=.*$/Name=WPS/' "$desktopFile"
      sed -i '/^Name\[/d' "$desktopFile"

      # 2. 确保 StartupWMClass 绑定到 wps-office2023-kprometheus（之前是 wpsoffice）
      sed -i 's/^StartupWMClass=.*$/StartupWMClass=wps-office2023-kprometheus/' "$desktopFile"

      # 3. 在 Categories 中添加 "Office"
      if grep -q "^Categories=" "$desktopFile"; then
        sed -i 's/^Categories=\(.*\)$/Categories=\1Office;/' "$desktopFile"
      else
        echo "Categories=Office;" >> "$desktopFile"
      fi
    fi

    # 需要系统的 freetype 和 gcc 库才能正常运行
    for i in wps wpp et wpspdf wpsoffice; do
      wrapProgram $out/opt/kingsoft/wps-office/office6/$i \
        --set LD_PRELOAD "${freetype}/lib/libfreetype.so" \
        --set LD_LIBRARY_PATH "${lib.makeLibraryPath [ gcc-unwrapped.lib ]}"
    done

    # 删除损坏的 libbz2.so 软链接，autoPatchelf 会自动链接到系统提供的 bzip2
    rm -f $out/opt/kingsoft/wps-office/office6/libbz2.so

    runHook postInstall
  '';

  preFixup = ''
    # The following libraries need libtiff.so.5, but nixpkgs provides libtiff.so.6
    patchelf --replace-needed libtiff.so.5 libtiff.so $out/opt/kingsoft/wps-office/office6/{libpdfmain.so,libqpdfpaint.so,qt/plugins/imageformats/libqtiff.so,addons/pdfbatchcompression/libpdfbatchcompressionapp.so}
    patchelf --replace-needed libtiff.so.5 libtiff.so $out/opt/kingsoft/wps-office/office6/addons/ksplitmerge/libksplitmergeapp.so
    patchelf --add-needed libtiff.so $out/opt/kingsoft/wps-office/office6/libwpsmain.so
    # Fix: Wrong JPEG library version: library is 62, caller expects 80
    patchelf --add-needed libjpeg.so $out/opt/kingsoft/wps-office/office6/libwpsmain.so
    # dlopen dependency
    patchelf --add-needed libudev.so.1 $out/opt/kingsoft/wps-office/office6/addons/cef/libcef.so
  '';

  meta = with lib; {
    description = "Office suite, formerly Kingsoft Office";
    homepage = "https://www.wps.com";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    hydraPlatforms = [ ];
    license = licenses.unfreeRedistributable;
    maintainers = with maintainers; [
      mlatus
      th0rgal
      rewine
      pokon548
    ];
  };
}
