final: prev: {
  librime =
    (prev.librime.override {
      plugins = [
        #           (pkgs.fetchFromGitHub {
        #             owner = "hchunhui";
        #             repo = "librime-lua";
        #             rev = "e3912a4b3ac2c202d89face3fef3d41eb1d7fcd6";
        #             sha256 = "sha256-zx0F41szn5qlc2MNjt1vizLIsIFQ67fp5cb8U8UUgtY=";
        #           })
        prev.librime-lua
        prev.librime-octagram
      ];
    }).overrideAttrs
      (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ prev.luajit ]; # 用luajit
        #         buildInputs = (old.buildInputs or []) ++ [pkgs.lua5_4]; # 用lua5.4
      });
}
