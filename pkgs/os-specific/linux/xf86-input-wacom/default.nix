{ lib, stdenv, fetchurl
, xorgproto, libX11, libXext, libXi, libXrandr, libXrender
, ncurses, pkg-config, xorgserver, udev, libXinerama, pixman }:

stdenv.mkDerivation rec {
  pname = "xf86-input-wacom";
  version = "0.40.0";

  src = fetchFromGitHub {
    owner = "linuxwacom";
    repo = "xf86-input-wacom";
    rev = "${pname}-${version}";
    sha256 = "0cwsjr42laicbj63rf0rd2adn2kvzcs0ab93m07qmvz1ch0a0lhx";
  };

  buildInputs = [ xorgproto libX11 libXext libXi libXrandr libXrender
    ncurses pkg-config xorgserver udev libXinerama pixman ];

  preConfigure = ''
    mkdir -p $out/share/X11/xorg.conf.d
    configureFlags="--with-xorg-module-dir=$out/lib/xorg/modules
    --with-sdkdir=$out/include/xorg --with-xorg-conf-dir=$out/share/X11/xorg.conf.d"
  '';

  CFLAGS = "-I${pixman}/include/pixman-1";

  meta = with lib; {
    maintainers = [ maintainers.goibhniu ];
    description = "Wacom digitizer driver for X11";
    homepage = "https://github.com/linuxwacom/xf86-input-wacom";
    license = licenses.gpl2;
    platforms = platforms.linux; # Probably, works with other unices as well
  };
}
