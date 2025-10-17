 VER="1.2.2"
 # VER="1.0.0_night"

 apt-get update -y
 apt-get install -y --no-install-recommends curl ca-certificates libgtk-4-dev libadwaita-1-dev git pkg-config xz-utils ncurses-term blueprint-compiler gettext pandoc ament-cmake-xmllint #libgtk4-layer-shell0 libgtk4-layer-shell-dev # python3-ament-xmllint
 cd /tmp

 ZV="0.15.2"
 curl https://ziglang.org/download/${ZV}/zig-linux-x86_64-${ZV}.tar.xz --output zig-linux-x86_64-${ZV}.tar.xz
 tar -xf zig-linux-x86_64-${ZV}.tar.xz -C /opt

 debdir="/ghostty"
 rm -rf $debdir /tmp/ghostty
 mkdir -p $debdir/DEBIAN
 git clone --recursive https://github.com/mitchellh/ghostty.git
 cd ghostty
 sed -i 's/linkSystemLibrary2("bzip2", dynamic_link_opts)/linkSystemLibrary2("bz2", dynamic_link_opts)/' src/build/SharedDeps.zig
 # grep 'linkSystemLibrary2("gtk4-layer-shell", dynamic_link_opts)' src/build/SharedDeps.zig
 # sed -i 's/linkSystemLibrary2("gtk4-layer-shell", dynamic_link_opts)/linkSystemLibrary2("gtk4-layer-shell0", dynamic_link_opts)/' src/build/SharedDeps.zig
 set advice.detachedHead="false"
 # export advice.detachedHead
 # git checkout v$VER
 # /opt/zig-linux-x86_64-${ZV}/zig build --summary all -p $debdir/usr -fsys=fontconfig -Doptimize=ReleaseFast -Dcpu=baseline -Dpie=true -Demit-docs --verbose-link
   /opt/zig-linux-x86_64-${ZV}/zig build --verbose-link -p $debdir/usr -fsys=fontconfig -Doptimize=ReleaseFast -Dcpu=baseline -Dstrip=true -Dpie=true -fno-sys=gtk4-layer-shell
#  cat <<END >> $debdir/DEBIAN/postinst
# ln -s /usr/lib/x86_64-linux-gnu/libgtk4-layer-shell.so.0 /usr/lib/x86_64-linux-gnu/libgtk4-layer-shell.so
# END
 chmod +x $debdir/DEBIAN/postinst
 chmod +x $debdir/DEBIAN/preinst
 chmod +x $debdir/DEBIAN/prerm

 # ln -s /usr/lib/x86_64-linux-gnu/libgtk4-layer-shell.so.0 /usr/lib/x86_64-linux-gnu/libgtk4-layer-shell.so
 VER=$($debdir/usr/bin/ghostty --version | head -n 1 | cut -d " " -f 2 )
 cd /
 [ -e /usr/share/terminfo/g/ghostty ] && mv $debdir/usr/share/terminfo/g/ghostty $debdir/usr/share/terminfo/g/ghostty.orig
 bind "set disable-completion on"
 cat <<END > ghostty/DEBIAN/control
Package: ghostty
Source: ghostty
Section: utils
Priority: optional
Version: $VER
Maintainer: Mitchell Hashimoto
Homepage: https://ghostty.org/
Architecture: amd64
Depends: libonig5, libgtk4-layer-shell0 | libgtk4-layer-shell
Description: Ghostty terminal emulator
END

 dpkg-deb --build -v ghostty ghostty_${VER}_amd64.deb
#  dpkg -i ghostty.deb

 #### test speed ####
 # cd /tmp
 # git clone https://github.com/const-void/DOOM-fire-zig/
 # cd DOOM-fire-zig
 # /opt/zig-linux-x86_64-0.13.0/zig build run

 rm -rf /tmp/* /opt/* /ghostty/*
 apt-get purge -y curl ca-certificates libgtk-4-dev libadwaita-1-dev git pkg-config xz-utils && \
 apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/*
