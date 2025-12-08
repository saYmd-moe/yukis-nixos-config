# Imported by: hosts/yuki-desktop/default.nix
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
