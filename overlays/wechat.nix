final: prev: {
  wechat = prev.symlinkJoin {
    name = "wechat";
    paths = [ prev.wechat ];
    nativeBuildInputs = [ prev.makeWrapper ];
    #postBuild = ''
    #  wrapProgram $out/bin/wechat \
    #    --set QT_SCALE_FACTOR 1.3
    #'';
  };
}
