{
  description = "A simple NixOS flake";

  ################################################################################
  #
  #  输入源配置 (Inputs)
  #
  #  定义系统依赖的外部 Flake 源，包括 Nixpkgs, Home Manager 等
  #
  ################################################################################
  inputs = {
    # NixOS 官方软件源，锁定在 nixos-25.11 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager: 用于管理用户级配置 (Dotfiles, 用户软件)
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # 强制 Home Manager 使用与系统一致的 Nixpkgs 版本，避免依赖冲突
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Daeuniverse: 提供现代化的代理工具 (dae/daed)
    daeuniverse.url = "github:daeuniverse/flake.nix";

    # DankMaterialShell & Niri
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ################################################################################
  #
  #  输出配置 (Outputs)
  #
  #  定义 NixOS 系统配置入口
  #
  ################################################################################
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.yuki-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          # ----------------------------------------------------------------------
          # 主机系统配置
          # ----------------------------------------------------------------------
          ./hosts/yuki-desktop/default.nix

          # ----------------------------------------------------------------------
          # Home Manager 模块集成
          # ----------------------------------------------------------------------
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 导入用户 'yuki' 的独立配置文件
            home-manager.users.yuki = import ./home/yuki/default.nix;

            # 将 Flake inputs 传递给 Home Manager，以便在 home.nix 中使用
            home-manager.extraSpecialArgs = { inherit inputs; }; # 这里的关键修复
          }
        ];
      };
    };
}
