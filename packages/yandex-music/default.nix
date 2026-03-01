{ stdenv
, lib
, dpkg
, autoPatchelfHook
, makeWrapper
, glibc
, xorg
, alsa-lib
, atk
, at-spi2-atk
, at-spi2-core
, cairo
, cups
, dbus
, expat
, fontconfig
, freetype
, gdk-pixbuf
, glib
, gtk3
, libdrm
, libxkbcommon
, mesa
, nspr
, nss
, pango
, fetchurl
}:

stdenv.mkDerivation {
  pname = "yandex-music";
  version = "5.89.0";

  src = fetchurl{
    url = "https://desktop.app.music.yandex.net/stable/Yandex_Music_amd64_5.89.0.deb";
    sha256 = "0xk0ag15a59q921ffbfpw43z33l5144rnmfy3ap1frgfh04rjml2";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook makeWrapper ];

  buildInputs = [
    glibc
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r opt usr $out/

    mkdir -p $out/bin

    makeWrapper "$out/opt/Яндекс Музыка/yandexmusic" $out/bin/yandex-music
  '';

  meta = with lib; {
    description = "Yandex Music Desktop";
    platforms = platforms.linux;
  };
}
