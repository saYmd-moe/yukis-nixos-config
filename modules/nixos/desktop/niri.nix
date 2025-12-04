# Imported by: hosts/yuki-desktop/default.nix
{
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  programs.niri = {
    enable = true;
  };

  systemd.user.services.niri-flake-polkit.enable = false;
}
