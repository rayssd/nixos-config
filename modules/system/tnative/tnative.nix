{ lib, pkgs, nim, fetchFromGitHub, stdenv, ... }:

stdenv.mkDerivation {
    pname = "tridactyl-native";
    version = "0.4.1";

    src = fetchFromGitHub {
      owner = "tridactyl";
      repo = "native_messenger";
      rev = "3059abd9fb3f14d598f6c299335c3ebac5bc689a";
      sha256 = "0wxszglhw5jqw87izi5a2wbqb65l5w6z7p326i66d2i8c2jis9w2";
    };

    lockFile = ./lock.json;

    nativeBuildInputs = [nim];

    installPhase = ''
      # mkdir -p "$out/lib/mozilla/native-messaging-hosts"
      mkdir -p "$HOME/.mozilla/native-messaging-hosts"
      sed -i -e "s|REPLACE_ME_WITH_SED|$out/bin/native_main|" "tridactyl.json"
      cp tridactyl.json "$HOME/.mozilla/native-messaging-hosts/"
    '';

    meta = with lib; {
      description =
        "Native messenger for Tridactyl, a vim-like Firefox webextension";
      homepage = "https://github.com/tridactyl/native_messenger";
      license = licenses.bsd2;
      platforms = platforms.all;
      maintainers = with maintainers; [ timokau dit7ya ];
    };
}
