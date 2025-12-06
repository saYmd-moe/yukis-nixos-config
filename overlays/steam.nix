final: prev: {
  steam = prev.steam.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      sed -i 's|^Exec=steam|Exec=steam -system-composer|' $out/share/applications/steam.desktop
    '';
  });
}
