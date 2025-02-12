 # VER="1.0.0"
 # VER="1.0.0_night"

 apt-get update -y
 apt-get install -y --no-install-recommends curl ca-certificates libgtk-4-dev libadwaita-1-dev git pkg-config xz-utils ncurses-term
 cd /tmp

 curl https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz --output zig-linux-x86_64-0.13.0.tar.xz
 tar -xf zig-linux-x86_64-0.13.0.tar.xz -C /opt

 debdir="/ghostty"
 mkdir -p $debdir/DEBIAN
 git clone --recursive https://github.com/mitchellh/ghostty.git
 cd ghostty
 sed -i 's/linkSystemLibrary2("bzip2", dynamic_link_opts)/linkSystemLibrary2("bz2", dynamic_link_opts)/' build.zig
 set advice.detachedHead="false"
 # export advice.detachedHead
 # git checkout v$VER
 /opt/zig-linux-x86_64-0.13.0/zig build --summary all -p $debdir/usr -fsys=fontconfig -Doptimize=ReleaseFast -Dcpu=baseline

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
Depends: libonig5
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
