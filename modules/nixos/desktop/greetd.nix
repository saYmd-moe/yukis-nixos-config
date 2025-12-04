# Imported by: hosts/yuki-desktop/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor = {
      name = "niri"; # Required. Can be also "hyprland" or "sway"
    };

    #TODO 根据实际用户名修改
    configHome = "/home/yuki";
    configFiles = [
      "/home/yuki/.config/DankMaterialShell/settings.json"
    ];

    # Save the logs to a file
    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };

  };

}
