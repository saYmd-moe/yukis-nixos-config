# Imported by: home/yuki/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
  ];

  ################################################################################
  #
  #  Dank Material Shell (DMShell)
  #
  ################################################################################

  programs.dankMaterialShell = {
    enable = true;

    niri = {
      enableKeybinds = false; # 手动调整键绑定以避免冲突
      enableSpawn = false; # Auto-start DMS with niri
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableBrightnessControl = true; # Backlight/brightness controls
    enableColorPicker = true; # Color picker tool
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableSystemSound = true; # System sound effects
  };

}
