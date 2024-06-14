apt-get update
apt-get install -y --no-install-recommends appstream curl ca-certificates tcl build-essential ccache cmake file gettext git libcurl4-openssl-dev libwebkit2gtk-4.1-dev liblua5.3-dev lsb-release pkg-config rapidjson-dev
#wx3.0-i18n libwxgtk-webview3.0-gtk3-dev libgtk-3-dev
cd /tmp

WX="3.2.5"
rm -fr moneymanagerex wxWidgets-$WX tmp
#git clone --recursive https://github.com/wxWidgets/wxWidgets.git
curl -fsSL -O https://github.com/wxWidgets/wxWidgets/releases/download/v$WX/wxWidgets-$WX.tar.bz2
tar xjf wxWidgets-$WX.tar.bz2
rm wxWidgets-$WX.tar.bz2
mkdir wxWidgets-$WX/build_gtk
pushd wxWidgets-$WX/build_gtk
../configure --disable-shared --enable-stl --with-cxx=20 --enable-utf8only --enable-intl --enable-xlocale --enable-webviewwebkit --with-gtk=3 # --without-libtiff --enable-monolithic --enable-webview --enable-unicode --enable-cxx13
make
popd

MMEX="1.8.1"
git clone --recursive https://github.com/moneymanagerex/moneymanagerex.git
set advice.detachedHead=false
pushd moneymanagerex
git checkout v$MMEX
popd
mkdir moneymanagerex/build
pushd moneymanagerex/build
export MAKEFLAGS=-j8
cmake -DCMAKE_CXX_FLAGS="-w" -DCMAKE_BUILD_TYPE=Release -DwxWidgets_CONFIG_EXECUTABLE=/tmp/wxWidgets-$WX/build_gtk/wx-config -DwxWidgets_LIBRARIES=/tmp/wxWidgets-$WX/build_gtk/lib -DwxWidgets_INCLUDE_DIRS=/tmp/wxWidgets-$WX/include -Wno-dev .. # -DCMAKE_PREFIX_PATH==/tmp/wxWidgets/build_gtk
sed -i 's!Debian.n/a!Debian!g' CPackConfig.cmake
cp /tmp/moneymanagerex/resources/dist/linux/share/metainfo/org.moneymanagerex.MMEX.metainfo.xml.in /tmp/moneymanagerex/org.moneymanagerex.MMEX.metainfo.xml
cmake --build . --target package
mv ./mmex*.deb /  # sudo apt install /mmex*.deb && rm ~/Downloads/mmex*.deb
popd
rm -fr moneymanagerex wxWidgets-$WX
apt-get purge -y tcl appstream build-essential ccache cmake file gettext git libcurl4-openssl-dev libwebkit2gtk-4.1-dev liblua5.3-dev lsb-release pkg-config rapidjson-dev && \
apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/*
