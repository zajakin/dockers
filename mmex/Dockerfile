FROM debian:testing-slim
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cmake build-essential gettext git pkg-config lsb-release file ccache \
        libwxgtk-webview3.0-gtk3-dev liblua5.2-dev libcurl4-openssl-dev && \
    apt-get clean
RUN git clone --recursive https://github.com/moneymanagerex/moneymanagerex && \
    mkdir moneymanagerex/build && cd moneymanagerex/build && \
    export MAKEFLAGS=-j8 && \
    cmake -DCMAKE_CXX_FLAGS="-w" -DCMAKE_BUILD_TYPE=Release .. && \
    cmake --build . --target package && \
    apt install -yqV ./mmex_*.deb
CMD ["/usr/bin/mmex"]
