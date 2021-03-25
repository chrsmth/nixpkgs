{ lib, stdenv, fetchFromGitHub
, xorgproto, libX11, libXext, libXi, libXrandr, libXrender
, ncurses, pkg-config, xorgserver, udev, libXinerama, pixman }:

stdenv.mkDerivation rec {
  pname = "xf86-input-wacom";
  version = "0.40.0";

  src = fetchFromGitHub {
    owner = "linuxwacom";
    repo = "xf86-input-wacom";
    rev = "${pname}-${version}";
    sha256 = "1jfd4j9mssbnj9xpixkbmg1fnw1c287ak080gd0qkc3g3q02jkni";
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
