 VER="1.0.0"
 # VER="1.0.0_night"

 apt-get update
 apt-get install -y --no-install-recommends curl ca-certificates libgtk-4-dev libadwaita-1-dev git pkg-config xz-utils
 cd /tmp

 curl https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz --output zig-linux-x86_64-0.13.0.tar.xz
 tar -xf zig-linux-x86_64-0.13.0.tar.xz -C /opt

 debdir="/ghostty"
 mkdir -p $debdir/DEBIAN
 git clone --recursive https://github.com/mitchellh/ghostty.git
 cd ghostty
 set advice.detachedHead="false"
 # export advice.detachedHead
 # git checkout v$VER
 /opt/zig-linux-x86_64-0.13.0/zig build -p $debdir/usr -fsys=fontconfig #  -Doptimize=ReleaseSafe

 VER=$($debdir/usr/bin/ghostty --version | head -n 1 | cut -d " " -f 2 )
 cd /
 bind "set disable-completion on"
 cat <<END > ghostty/DEBIAN/control
Package: ghostty
Version: $VER
Maintainer: Mitchell Hashimoto
Architecture: all
Description: Ghostty terminal emulator
END

 dpkg-deb --build -v ghostty ghostty_${VER}_amd64.deb
#  dpkg -i ghostty.deb
 rm -rf /tmp/* /opt/* /ghostty/*
 apt-get purge -y curl ca-certificates libgtk-4-dev libadwaita-1-dev git pkg-config xz-utils && \
 apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/*
