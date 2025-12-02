{
  lib,
  stdenv,
  fetchFromGitHub,
}:

let
  fontSource1 = fetchFromGitHub {
    owner = "jiaxiaochu";
    repo = "font";
    rev = "613a015764a97901c4de077b71e1d60f17254e87";
    sha256 = "sha256-TbkfnjGazEciR1KxdtSHtKFTTbcQ3uXy9dFMSu1G+BQ=";
  };

  fontSource2 = fetchFromGitHub {
    owner = "BannedPatriot";
    repo = "ttf-wps-fonts";
    rev = "8c980c24289cb08e03f72915970ce1bd6767e45a";
    sha256 = "sha256-x+grMnpEGLkrGVud0XXE8Wh6KT5DoqE6OHR+TS6TagI=";
  };

in
stdenv.mkDerivation rec {
  pname = "chinese-fonts-pack";
  version = "613a015-8c980c2";

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    local font_dir=$out/share/fonts/truetype
    install -d $font_dir

    find ${fontSource2} -type f \( -iname "*.ttf" -o -iname "*.ttc" -o -iname "*.otf" \) \
      -exec install -Dm644 -t $font_dir {} +

    find ${fontSource1} -maxdepth 1 -type f \( -iname "*.ttf" -o -iname "*.ttc" -o -iname "*.otf" \) -print0 | while IFS= read -r -d $'\0' font_file; do
      font_basename=$(basename "$font_file")
      
      if [ ! -f "$font_dir/$font_basename" ]; then
        install -Dm644 "$font_file" "$font_dir/$font_basename"
      fi
    done

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/Beriholic/nix-wpsoffice-cn";
    description = "A merged collection of common Chinese, programming, and WPS fonts";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = with maintainers; [ Beriholic ];
  };
}
