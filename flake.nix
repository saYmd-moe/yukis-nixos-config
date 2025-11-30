{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS 官方软件源，这里使用 nixos-25.05 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # home-manager, 管理用户配置
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # 输入中的 `follows` 关键字用于继承。
      # 这里，home-manager 的 `inputs.nixpkgs` 与
      # 当前 flakes 的 `inputs.nixpkgs` 保持一致、
      # 以避免 nixpkgs 版本不同造成的问题。
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dae, a proxy application
    daeuniverse.url = "github:daeuniverse/flake.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.yuki-desktop = nixpkgs.lib.nixosSystem {
        modules = [
          # 导入 configuration.nix，
          ./hosts/yuki-desktop/default.nix

          # 将 home-manager 配置为 nixos 的一个 module
          # 这样在 nixos-rebuild switch 时，home-manager 配置也会被自动部署
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.yuki = import ./home/yuki/default.nix;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            home-manager.extraSpecialArgs = inputs;
          }

          inputs.daeuniverse.nixosModules.daed
        ];
      };
    };
}
