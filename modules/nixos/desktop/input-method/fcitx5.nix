{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  输入法 (Fcitx5 + Rime)
  #
  ################################################################################

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-nord
    ];
  };
}
