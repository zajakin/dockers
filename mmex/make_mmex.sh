apt-get update
apt-get install -y --no-install-recommends curl ca-certificates tcl build-essential ccache cmake file gettext git libcurl4-openssl-dev libwebkit2gtk-4.0-dev liblua5.3-dev lsb-release pkg-config rapidjson-dev
#wx3.0-i18n libwxgtk-webview3.0-gtk3-dev libgtk-3-dev
cd /tmp

WX="3.2.1"
rm -fr moneymanagerex wxWidgets-$WX
#git clone --recursive https://github.com/wxWidgets/wxWidgets.git
curl -fsSL -O https://github.com/wxWidgets/wxWidgets/releases/download/v$WX/wxWidgets-$WX.tar.bz2
tar xjf wxWidgets-$WX.tar.bz2
rm wxWidgets-$WX.tar.bz2
mkdir wxWidgets-$WX/build_gtk
pushd wxWidgets-$WX/build_gtk
../configure --disable-shared --enable-cxx11 --with-cxx=11 --without-libtiff # --enable-webview --enable-monolithic --enable-unicode
make
popd

MMEX="1.6.4"
git clone --recursive https://github.com/moneymanagerex/moneymanagerex.git
pushd moneymanagerex && git checkout v$MMEX && popd
mkdir moneymanagerex/build
pushd moneymanagerex/build
export MAKEFLAGS=-j8
cmake -DCMAKE_CXX_FLAGS="-w" -DCMAKE_BUILD_TYPE=Release -DwxWidgets_CONFIG_EXECUTABLE=/tmp/wxWidgets-$WX/build_gtk/wx-config -Wno-dev .. #-DCMAKE_INCLUDE_PATH=/tmp/wxWidgets/include/wx -DCMAKE_PREFIX_PATH==/tmp/wxWidgets/build_gtk -DCMAKE_LIBRARY_PATH=/tmp/wxWidgets/build_gtk/lib
sed -i 's!Debian.n/a!Debian!g' CPackConfig.cmake
cmake --build . --target package
mv ./mmex*.deb /  # sudo apt install /mmex*.deb && rm ~/Downloads/mmex*.deb
popd
rm -fr moneymanagerex wxWidgets-$WX
apt-get purge -y tcl build-essential ccache cmake file gettext git libcurl4-openssl-dev libwebkit2gtk-4.0-dev liblua5.3-dev lsb-release pkg-config rapidjson-dev && \
apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/*
