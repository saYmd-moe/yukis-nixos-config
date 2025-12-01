# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # 导入通用主机配置
    ../default.nix
    # 导入硬件扫描配置
    ./hardware-configuration.nix

    # 导入主机模块
    # 硬件配置
    ../../modules/nixos/hardware/arcgpu.nix
    ../../modules/nixos/hardware/audio.nix
    ../../modules/nixos/hardware/peripherals.nix

    # 桌面环境
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/input-method/fcitx5.nix

    # 系统服务
    ../../modules/nixos/services/daed.nix
    ../../modules/nixos/services/steam.nix

  ];

  ################################################################################
  #
  #  文件系统与存储
  #
  ################################################################################

  # 挂载 Windows NTFS 分区
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/EA9572B0D459FB63";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=000"
      "windows_names"
      "nofail"
    ];
  };

  ################################################################################
  #
  #  系统引导与内核
  #
  ################################################################################

  # 启用 systemd-boot 引导加载程序
  boot.loader.systemd-boot.enable = true;

  # EFI 配置
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # 使用最新的 Linux 内核
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ################################################################################
  #
  #  网络配置
  #
  ################################################################################

  networking.hostName = "yuki-desktop"; # 主机名

  # 启用 NetworkManager 网络管理工具
  networking.networkmanager.enable = true;

  # 代理设置 (如有需要可取消注释)
  #networking.proxy.default = "http://192.168.31.157:2080";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ################################################################################
  #
  #  用户配置
  #
  ################################################################################

  users.users.yuki = {
    isNormalUser = true;
    description = "MercuryMoe";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      # 系统级用户软件 (建议在 home-manager 中管理)
      #kdePackages.kate
      #thunderbird
    ];
  };

  # 允许 wheel 组用户免密 sudo
  security.sudo.wheelNeedsPassword = false;

  ################################################################################
  #
  #  系统软件包与环境
  #
  ################################################################################

  # 系统级软件包 (仅保留 yuki-desktop 特有的)
  environment.systemPackages = with pkgs; [
    # --- 核心工具 (vim, wget, git 等已在 default.nix 中) ---
    refind

    # --- 美化 ---
    papirus-icon-theme
  ];

  ################################################################################
  #
  #  系统状态版本
  #
  ################################################################################

  # ⚠️ 此选项定义了系统状态的兼容性版本，请勿随意更改
  system.stateVersion = "25.05";

}
